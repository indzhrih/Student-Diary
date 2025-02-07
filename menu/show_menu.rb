require_relative 'base_menu'
require_relative 'dialog'
require 'value_classes/semester'

module Menu
  class ShowMenu < BaseMenu
    class << self
      def perform
        variants
        choice_menu
      end

      private

      def variants
        puts "Введите название семестра, который хотите отобразить или 0 если хотите вернуться назад \n"\
             "Добавленные семестры:\n"
        ValueClasses::Semester.show_added
      end

      def choice_menu
        @choice = gets.chomp
        chosen_sem = ValueClasses::Semester.find_sem(@choice)

        return show_sem(chosen_sem) if chosen_sem.nil? == false
        return Menu.start if @choice.chomp == '0'

        Menu.warning("Указанный семестр не найден!\nПожалуйста введите корректное значение", 2)
      end

      def show_sem(sem)
        info = get_sem_info(sem)
        disciplines_info = show_sem_disciplines(sem)

        puts "Семестр: #{info[:name]}\n"\
             "- Дата начала: #{info[:start_date]}\n"\
             "- Дата окончания: #{info[:end_date]}\n"\
             "- Статус: #{info[:status]}\n"\
             "--------------------------\n"\
             "#{disciplines_info}"

        perform
      end

      def show_discipline(discipline)
        info = get_discipline_info(discipline)
        labs_info = show_discipline_labs(discipline)

        "Предмет: #{info[:name]}\n"\
               " #{labs_info}\n"\
               '--------------------------'
      end

      def show_lab(lab)
        info = get_lab_info(lab)
        status_info = show_status_info(lab)

        "[#{info[:status]}] #{info[:name]}\n#{status_info}"
      end

      def get_sem_info(sem)
        {
          id: sem.id,
          name: sem.name,
          start_date: sem.start_date,
          end_date: sem.end_date,
          status: sem.is_active,
          disciplines: ValueClasses::Discipline.get_disciplines_to_sem(sem.id)
        }
      end

      def get_discipline_info(discipline)
        {
          id: discipline.id,
          name: discipline.name,
          semester_id: discipline.semester_id,
          labs: ValueClasses::Lab.get_labs_to_disciplines(discipline.id)
        }
      end

      def get_lab_info(lab)
        {
          id: lab.id,
          name: lab.name,
          deadline: lab.deadline,
          status: lab.status,
          mark: lab.mark,
          discipline_id: lab.discipline_id
        }
      end

      def show_sem_disciplines(sem)
        info = get_sem_info(sem)

        return 'Дисциплины не добавлены' if info[:disciplines].empty?

        info[:disciplines].map { |discipline| show_discipline(discipline) }.join("\n")
      end

      def show_discipline_labs(discipline)
        info = get_discipline_info(discipline)

        return "Лабараторные работы не добавлены\n" if info[:labs].empty?

        info[:labs].map { |lab| show_lab(lab) }.join("\n")
      end

      def show_status_info(lab)
        info = get_lab_info(lab)

        return "Оценка: #{info[:mark]}" if info[:status] == 'Выполнено'

        "Дедлайн: #{info[:deadline]}"
      end
    end
  end

  class << self
    def show
      ShowMenu.perform
    end
  end
end
