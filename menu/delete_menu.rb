# frozen_string_literal: true

require_relative 'base_menu'
require_relative 'incorrect_value_menu'
require_relative '../queries/semester_query'
require_relative '../queries/discipline_query'
require_relative '../queries/lab_query'
require_relative '../commands/delete_object'

module Menu
  class DeleteMenu < BaseMenu
    class << self
      def perform
        show_objects_variants
        choice_menu
      end

      private

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1
            delete_object(object_type: :semester)
            break
          when 2
            delete_object(object_type: :discipline)
            break
          when 3
            delete_object(object_type: :lab)
            break
          when 4
            puts 'Назад...'
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 4)
          end
        end
      end

      def show_objects_variants
        puts "Выберите что вы хотите удалить:\n"\
             "1.Семестр\n"\
             "2.Дисциплина\n"\
             "3.Лабараторная\n"\
             '4.Назад'
      end

      def show_sem_variants
        puts get_variants_string(table_name: 'Семестр')

        Queries::SemesterQuery.show_added_sems
      end

      def show_discipline_variants(id:)
        puts get_variants_string(table_name: 'Дисциплина')

        Queries::SemesterQuery.show_disciplines_for_sem(sem_id: id)
      end

      def show_lab_variants(id:)
        puts get_variants_string(table_name: 'Лабараторная')

        Queries::DisciplineQuery.show_labs_for_discipline(discipline_id: id)
      end

      def delete_object(object_type:)
        Commands::DeleteCommand.perform(object: choice_object(object_type: object_type), object_type: object_type)
        perform
      end

      def choice_object(object_type:)
        case object_type
        when :semester
          semester_choice
        when :discipline
          discipline_choice
        when :lab
          lab_choice
        end
      end

      def semester_choice
        show_sem_variants

        sem = Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: get_name)
        object_check(object: sem, choice: 4)
      end

      def discipline_choice
        sem_id = choice_object(object_type: :semester).get_json_info[:id]
        show_discipline_variants(id: sem_id)

        discipline = Queries::DisciplineQuery.find_discipline_by_name_and_sem_id(discipline: get_name, sem_id: sem_id)
        object_check(object: discipline, choice: 4)
      end

      def lab_choice
        discipline_id = choice_object(object_type: :discipline).get_json_info[:id]
        show_lab_variants(id: discipline_id)

        lab = Queries::LabQuery.find_lab_by_name_and_discipline_id(lab: get_name, discipline_id: discipline_id)
        object_check(object: lab, choice: 4)
      end
    end
  end
end
