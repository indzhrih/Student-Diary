require 'date'
require_relative '../query_objects/semester_query'
require_relative '../menu/create_menu'

module FormObjects
  class SemesterForm
    class << self
      def create_semester
        QueryObjects::SemesterQuery.add_to_d_b(info: get_info)
        Menu::CreateMenu.perform
      end

      private

      def get_info
        info = {}
        puts 'Введите название Семестра'
        info[:name] = gets.chomp
        puts 'Введите дату начала формата ДД-ММ-ГГГГ'
        info[:start_date] = validate_date
        puts 'Введите дату окончания формата ДД-ММ-ГГГГ'
        info[:end_date] = validate_date
        puts 'Введите статус(Активен или Не активен)'
        info[:active] = validate_status
        info
      end

      def validate_date
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
        until ['активен', 'не активен'].include?(status.downcase)
          puts 'Неверный формат статуса, он должен быть Активен или Не активен'
          status = gets.chomp
        end

        return true if status.downcase == 'активен'

        false if status.downcase == 'не активен'
      end
    end
  end
end
