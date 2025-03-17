# frozen_string_literal: true

require_relative 'base_menu'
require_relative '../forms/semester_form'
require_relative '../forms/discipline_form'
require_relative '../forms/lab_form'

module Menu
  class CreateMenu < BaseMenu
    class << self
      def perform
        show_objects_variants
        choice_menu
      end

      private

      def show_objects_variants
        puts "Выберите что вы хотите создать:\n"\
             "1.Семестр\n"\
             "2.Дисциплина\n"\
             "3.Лабараторная\n"\
             '4.Назад'
      end

      def show_sem_variants
        puts get_variants_string(table_name: 'Семестр')

        Queries::SemesterQuery.show_added_sems
      end

      def show_discipline_variants(sem_id:)
        puts get_variants_string(table_name: 'Дисциплина')

        Queries::SemesterQuery.show_disciplines_for_sem(sem_id: sem_id)
      end

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1
            create_object(object_type: :semester)
            break
          when 2
            create_object(object_type: :discipline)
            break
          when 3
            create_object(object_type: :lab)
            break
          when 4
            puts 'Назад...'
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 3)
          end
        end
      end

      def create_object(object_type:)
        case object_type
        when :semester
          Forms::SemesterForm.create_semester
          perform
        when :discipline
          Forms::DisciplineForm.create_discipline(sem_id: semester_choice.get_json_info[:id])
          perform
        when :lab
          Forms::LabForm.create_lab(discipline_id: discipline_choice.get_json_info[:id])
          perform
        end
      end

      def semester_choice
        show_sem_variants

        object_check(object: Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: get_name), choice: 3)
      end

      def discipline_choice
        sem_id = semester_choice.get_json_info[:id]
        show_discipline_variants(sem_id: sem_id)

        object_check(
          object: Queries::DisciplineQuery.find_discipline_by_name_and_sem_id(discipline: get_name,
                                                                              sem_id: sem_id), choice: 3
        )
      end
    end
  end
end
