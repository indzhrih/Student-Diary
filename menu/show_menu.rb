require_relative 'base_menu'
require_relative '../queries/semester_query'
require_relative '../value_classes/semester'

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
        Queries::SemesterQuery.show_added_sems
      end

      def choice_menu
        @choice = gets.chomp
        chosen_sem = Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: @choice)

        return show_sem(sem: chosen_sem) if chosen_sem.nil? == false
        return Menu.start if @choice.chomp == '0'

        Menu.warning(message: "Указанный семестр не найден!\nПожалуйста введите корректное значение", choice: 2)
      end

      def show_sem(sem:)
        info = sem.get_json_info
        disciplines_info = show_sem_disciplines(sem: sem, info: info)

        puts "Семестр: #{info[:name]}\n"\
             "- Дата начала: #{info[:start_date]}\n"\
             "- Дата окончания: #{info[:end_date]}\n"\
             "- Статус: #{info[:active]}\n"\
             "--------------------------\n"\
             "#{disciplines_info}"

        perform
      end

      def show_discipline(discipline:)
        info = discipline.get_json_info
        labs_info = show_discipline_labs(discipline: discipline, info: info)

        "Предмет: #{info[:name]}\n"\
        "#{labs_info}\n"\
        '--------------------------'
      end

      def show_lab(lab:)
        info = lab.get_json_info
        status_info = show_status_info(lab: lab, info: info)

        "[#{info[:completed]}] #{info[:name]}\n#{status_info}"
      end

      def show_sem_disciplines(sem:, info:)
        return 'Дисциплины не добавлены' if info[:disciplines].empty?

        info[:disciplines].map { |discipline| show_discipline(discipline: discipline) }.join("\n")
      end

      def show_discipline_labs(discipline:, info:)
        return "Лабараторные работы не добавлены\n" if info[:labs].empty?

        info[:labs].map { |lab| show_lab(lab: lab) }.join("\n")
      end

      def show_status_info(lab:, info:)
        return "Оценка: #{info[:mark]}" if info[:completed] == 'Выполнено'

        "Дедлайн: #{info[:deadline]}"
      end
    end
  end
end
