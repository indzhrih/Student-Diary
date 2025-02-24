require_relative 'base_menu'
require_relative '../queries/semester_query'
require_relative '../queries/discipline_query'
require_relative '../queries/lab_query'
require_relative '../commands/delete_semester'
require_relative '../commands/delete_discipline'
require_relative '../commands/delete_lab'

module Menu
  class DeleteMenu < BaseMenu
    class << self
      def perform
        show_objects_variants
        choice_menu
      end

      private

      def show_objects_variants
        puts "Выберите что вы хотите удалить:\n"\
             "1.Семестр\n"\
             "2.Дисциплина\n"\
             "3.Лабараторная\n"\
             '4.Назад'
      end

      def show_sem_variants
        puts "Введите название семестра, или 0 если хотите вернуться назад\n"\
             "Добавленные семестры:\n"
        Queries::SemesterQuery.show_added_sems
      end

      def show_discipline_variants(sem_id:)
        puts "Введите название дисциплины или 0 если хотите вернуться назад\n"\
             "Добавленные дисциплины:\n"
        Queries::SemesterQuery.show_disciplines_for_sem(sem_id: sem_id)
      end

      def show_lab_variants(discipline_id:)
        puts "Введите название лабы или 0 если хотите вернуться назад\n"\
             "Добавленные дисциплины:\n"
        Queries::DisciplineQuery.show_labs_for_discipline(discipline_id: discipline_id)
      end

      def delete_semester
        show_sem_variants
        sem_name = gets.chomp
        Commands::DeleteSemester.delete_semester(sem_name: sem_name)
        perform
      end

      def delete_discipline
        show_sem_variants
        sem_id = choice_sem_menu
        show_discipline_variants(sem_id: sem_id)
        choice_discipline_menu(sem_id: sem_id, deletion_choice: 1)
        perform
      end

      def delete_lab
        show_sem_variants
        sem_id = choice_sem_menu
        show_discipline_variants(sem_id: sem_id)
        discipline_id = choice_discipline_menu(sem_id: sem_id, deletion_choice: 2)
        show_lab_variants(discipline_id: discipline_id)
        choice_lab_menu(discipline_id: discipline_id)
        perform
      end

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1
            delete_semester
            break
          when 2
            delete_discipline
            break
          when 3
            delete_lab
            break
          when 4
            puts 'Назад...'
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 4)
          end
        end
      end

      def choice_sem_menu
        @choice = gets.chomp
        chosen_sem = Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: @choice)

        return chosen_sem.get_json_info[:id] if chosen_sem.nil? == false
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанный семестр не найден!\nПожалуйста введите корректное значение", choice: 4)
      end

      def choice_discipline_menu(sem_id:, deletion_choice:)
        @choice = gets.chomp
        chosen_discipline = Queries::DisciplineQuery.find_discipline_by_name_and_sem_id(discipline: @choice,
                                                                                        sem_id: sem_id)

        if chosen_discipline.nil? == false && deletion_choice == 1
          return Commands::DeleteDiscipline.delete_discipline(discipline_id: chosen_discipline.get_json_info[:id].to_i)
        end
        return chosen_discipline.get_json_info[:id].to_i if chosen_discipline.nil? == false && deletion_choice == 2
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанная дисциплина не найдена!\nПожалуйста введите корректное значение", choice: 4)
      end

      def choice_lab_menu(discipline_id:)
        @choice = gets.chomp
        chosen_lab = Queries::LabQuery.find_lab_by_name_and_discipline_id(lab: @choice,
                                                                          discipline_id: discipline_id)

        if chosen_lab.nil? == false
          return Commands::DeleteLab.delete_lab(lab_id: chosen_lab.get_json_info[:id].to_i)
        end
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанная дисциплина не найдена!\nПожалуйста введите корректное значение", choice: 4)
      end
    end
  end
end
