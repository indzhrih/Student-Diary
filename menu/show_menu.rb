# frozen_string_literal: true

require_relative 'base_menu'
require_relative '../decorators/analyze_decorator'
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
        puts "Введите, что вы хотите вывести:\n"\
             "1.Вывести определенный семестр\n"\
             "2.Активные семестры\n"\
             "3.Семестры, в которых есть определенная дисциплина\n"\
             "4.Вывести семестры, в порядке приближения окончания\n"\
             "5.Вывести семестры, с отсортированными дисциплинами, по среднему баллу\n"\
             '6.Назад'
      end

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1..5
            data = Decorators::AnalyzeDecorator.analyze_data_by_type(sort_type: @choice)

            return Menu.warning(message: 'По вашим данным ничего не найдено!', choice: 2) if data.nil? || data.empty?

            data.each { |sem| show_sem(sem: sem) }
            perform
            break
          when 6
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 2)
          end
        end
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
        return "Оценка: #{info[:mark].to_i}" if info[:completed] == 'Выполнено'

        "Дедлайн: #{info[:deadline]}"
      end
    end
  end
end
