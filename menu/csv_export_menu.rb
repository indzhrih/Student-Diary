require_relative 'base_menu'
require_relative '../commands/csv_export_command'

module Menu
  class CSVExportMenu < BaseMenu
    class << self
      def perform
        show_export_variants
        choice_menu
        perform
      end

      private

      def show_export_variants
        puts "Выберите какую таблицу вы хотите экспортировать:\n"\
             "1.Семестры\n"\
             "2.Дисциплины\n"\
             "3.Лабараторные\n"\
             '4.Назад'
      end

      def choice_menu
        loop do
          @choice = gets.to_i
          case @choice
          when 1
            Commands::CSVExprotCommand.export_table(table_name: :semester)
            break
          when 2
            Commands::CSVExprotCommand.export_table(table_name: :discipline)
            break
          when 3
            Commands::CSVExprotCommand.export_table(table_name: :lab)
            break
          when 4
            puts 'Назад...'
            Menu.start
          else
            Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 5)
          end
        end
      end
    end
  end
end
