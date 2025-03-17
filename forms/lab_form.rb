# frozen_string_literal: true

require 'date'
require_relative '../queries/lab_query'
require_relative '../value_classes/discipline'
require_relative '../menu/create_menu'

module Forms
  class LabForm
    class << self
      def create_lab(discipline_id:)
        Queries::LabQuery.add_to_d_b(lab: get_info(discipline_id: discipline_id))
      end

      private

      def get_info(discipline_id:)
        puts 'Введите название Лабараторной'
        name = validate_name
        puts 'Введите дедлайн формата ДД-ММ-ГГГГ'
        deadline = validate_deadline
        puts 'Введите статус(Выполнено или Не выполнено)'
        status = validate_status
        puts 'Введите оценку'
        mark = validate_mark

        [name, deadline, mark.to_i, status, discipline_id]
      end

      def validate_name
        name = gets.chomp
        while name.empty?
          puts 'Имя не может быть пустым!'
          name = gets.chomp
        end
        name
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
        while ['выполнено', 'не выполнено'].include?(status.downcase) == false
          puts 'Неверный формат статуса, он должен быть Выполнено или Не выполнено'
          status = gets.chomp
        end

        status.downcase == 'выполнено'
      end

      def validate_mark
        mark = gets.chomp
        while mark.to_i < 0 || mark.to_i > 10
          puts 'Неверный формат оценки, оценка должна быть от 0 до 10'
          mark = gets.chomp
        end

        mark.to_i
      end
    end
  end
end
