require_relative 'base_menu'
require_relative '../form_objects/semester_form'
require_relative '../form_objects/discipline_form'
require_relative '../form_objects/lab_form'

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
        puts "Введите название семестра, в который хотите добавить новую дисциплину или 0 если хотите вернуться назад\n"\
             "Добавленные семестры:\n"
        QueryObjects::SemesterQuery.show_added_sems
      end

      def show_discipline_variants(sem_id:)
        puts "Введите название дисциплины, в который хотите добавить новую лабу или 0 если хотите вернуться назад\n"\
             "Добавленные дисциплины:\n"
        QueryObjects::DisciplineQuery.show_added_disciplines_by_id(sem_id: sem_id)
      end

      def create_discipline
        show_sem_variants
        choice_sem_menu(creation_choice: 1)
      end

      def create_lab
        show_sem_variants
        sem_id = choice_sem_menu(creation_choice: 2)
        show_discipline_variants(sem_id: sem_id)
        choice_discipline_menu(sem_id: sem_id)
      end

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1
            FormObjects::SemesterForm.create_semester
            break
          when 2
            create_discipline
            break
          when 3
            create_lab
            break
          when 4
            puts 'Назад...'
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 3)
          end
        end
      end

      def choice_sem_menu(creation_choice:)
        @choice = gets.chomp
        chosen_sem = QueryObjects::SemesterQuery.find_sem_by_name(sem_name: @choice)

        if chosen_sem.nil? == false && creation_choice == 1
          return FormObjects::DisciplineForm.create_discipline(sem_id: chosen_sem.get_json_info[:id])
        end
        return chosen_sem.get_json_info[:id] if chosen_sem.nil? == false && creation_choice == 2
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанный семестр не найден!\nПожалуйста введите корректное значение", choice: 3)
      end

      def choice_discipline_menu(sem_id:)
        @choice = gets.chomp
        chosen_discipline = QueryObjects::DisciplineQuery.find_discipline_by_sem_id(discipline: @choice, sem_id: sem_id)

        if chosen_discipline.nil? == false
          return FormObjects::LabForm.create_lab(discipline_id: chosen_discipline.get_json_info[:id])
        end
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанная дисциплина не найдена!\nПожалуйста введите корректное значение", choice: 3)
      end
    end
  end
end
