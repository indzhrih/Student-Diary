require 'date'
require_relative '../queries/semester_query'
require_relative '../value_classes/semester'
require_relative '../menu/create_menu'

module Forms
  class SemesterForm
    class << self
      def create_semester
        Queries::SemesterQuery.add_to_d_b(sem: get_info)
      end

      private

      def get_info
        puts 'Введите название Семестра'
        name = validate_name
        puts 'Введите дату начала формата ДД-ММ-ГГГГ'
        start_date = validate_date
        puts 'Введите дату окончания формата ДД-ММ-ГГГГ'
        end_date = validate_date
        puts 'Введите статус(Активен или Не активен)'
        active = validate_status

        [name, start_date, end_date, active]
      end

      def validate_name
        name = gets.chomp
        while Queries::SemesterQuery.is_name_unique(name: name) == false
          puts 'Такое имя уже есть!'
          name = gets.chomp
        end

        name
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
        while ['активен', 'не активен'].include?(status.downcase) == false
          puts 'Неверный формат статуса, он должен быть Активен или Не активен'
          status = gets.chomp
        end

        status.downcase == 'активен'
      end
    end
  end
end
