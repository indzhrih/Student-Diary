require 'date'
require_relative '../query_objects/lab_query'
require_relative '../menu/create_menu'

module FormObjects
  class LabForm
    class << self
      def create_lab(discipline_id:)
        QueryObjects::LabQuery.add_to_d_b(discipline_id: discipline_id, info: get_info)
        Menu::CreateMenu.perform
      end

      private

      def get_info
        info = {}
        puts 'Введите название Лабараторной'
        info[:name] = gets.chomp
        puts 'Введите дедлайн формата ДД-ММ-ГГГГ'
        info[:deadline] = validate_deadline
        puts 'Введите статус(Выполнено или Не выполнено)'
        info[:status] = validate_status
        puts 'Введите оценку'
        info[:mark] = validate_mark
        info
      end

      def validate_deadline
        loop do
          date = gets.chomp
          day, month, year = date.split('-').map(&:to_i)
          Date.new(year, month, day)
          return date
        rescue StandardError
          puts 'Неверный формат даты или некорректные значения дня/месяца/года!'
        end
      end

      def validate_status
        status = gets.chomp
        until ['выполнено', 'не выполнено'].include?(status.downcase)
          puts 'Неверный формат статуса, он должен быть Выполнено или Не выполнено'
          status = gets.chomp
        end

        return true if status.downcase == 'выполнено'

        false if status.downcase == 'не выполнено'
      end

      def validate_mark
        mark = gets.chomp
        until mark.to_i > 0 && mark.to_i <= 10
          puts 'Неверный формат оценки, оценка должна быть от 0 до 10'
          mark = gets.chomp
        end

        mark.to_i
      end
    end
  end
end
