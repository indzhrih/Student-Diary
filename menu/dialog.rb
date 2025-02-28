require_relative 'base_menu'
require_relative 'show_menu'
require_relative 'create_menu'
require_relative 'delete_menu'
require_relative 'exit_menu'
require_relative 'incorrect_value_menu'

module Menu
  class Dialog < BaseMenu
    def start_dialog
      show_variants
      start_menu
    end

    private

    def show_variants
      puts "Выберите что вы хотите сделать:\n"\
           "1.Просмотреть Семестры/Дисциплины/Лабораторные\n"\
           "2.Создать Семестры/Дисциплины/Лабораторные\n"\
           "3.Удалить Семестры/Дисциплины/Лабораторные\n"\
           "4.Эксопртировать Семестры/Дисциплины/Лабораторные в csv\n"\
           "5.Выход\n"\
    end

    def start_menu
      loop do
        @choice = gets.to_i
        case @choice
        when 1
          Menu.show
          break
        when 2
          Menu.create
          break
        when 3
          Menu.delete
          break
        when 4
          Menu.csv_export
          Menu.exit_application(message: 'Выходим...')
        when 5
          Menu.exit_application(message: 'Выходим...')
        else
          Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 1)
        end
      end
    end
  end
end
