require_relative 'base_menu'
require 'query_objects/semester_query'
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
        QueryObjects::SemesterQuery.show_added_sems
      end

      def choice_menu
        @choice = gets.chomp
        chosen_sem = QueryObjects::SemesterQuery.find_sem(@choice)

        return show_sem(chosen_sem) if chosen_sem.nil? == false
        return Menu.start if @choice.chomp == '0'

        Menu.warning("Указанный семестр не найден!\nПожалуйста введите корректное значение", 2)
      end

      def show_sem(sem)
        info = sem.get_json_info
        disciplines_info = show_sem_disciplines(sem, info)

        puts "Семестр: #{info[:name]}\n"\
             "- Дата начала: #{info[:start_date]}\n"\
             "- Дата окончания: #{info[:end_date]}\n"\
             "- Статус: #{info[:active]}\n"\
             "--------------------------\n"\
             "#{disciplines_info}"

        perform
      end

      def show_discipline(discipline)
        info = discipline.get_json_info
        labs_info = show_discipline_labs(discipline, info)

        "Предмет: #{info[:name]}\n"\
        "#{labs_info}\n"\
        '--------------------------'
      end

      def show_lab(lab)
        info = lab.get_json_info
        status_info = show_status_info(lab, info)

        "[#{info[:completed]}] #{info[:name]}\n#{status_info}"
      end

      def show_sem_disciplines(_sem, info)
        return 'Дисциплины не добавлены' if info[:disciplines].empty?

        info[:disciplines].map { |discipline| show_discipline(discipline) }.join("\n")
      end

      def show_discipline_labs(_discipline, info)
        return "Лабараторные работы не добавлены\n" if info[:labs].empty?

        info[:labs].map { |lab| show_lab(lab) }.join("\n")
      end

      def show_status_info(_lab, info)
        return "Оценка: #{info[:mark]}" if info[:completed] == 'Выполнено'

        "Дедлайн: #{info[:deadline]}"
      end
    end
  end
end
