require_relative 'base_menu'
require_relative 'show_menu'
require_relative 'create_menu'
require_relative 'delete_menu'
require_relative 'exit_menu'
require_relative 'incorrect_value_menu'

module Menu
  class Dialog < BaseMenu
    def initialize
      @choice = 0
    end

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
           "4.Выход\n"\
    end

    def start_menu
      loop do
        @choice = gets.to_i
        case @choice
        when 1
          Menu.show('Вы выбрали Просмотр, но эта функция еще не была добавлена')
          break
        when 2
          Menu.create('Вы выбрали Создание, но эта функция еще не была добавлена')
          break
        when 3
          Menu.delete('Вы выбрали Удаление, но эта функция еще не была добавлена')
          break
        when 4
          Menu.exit_application('Выходим...')
        else
          Menu.warning('Пожалуйста введите корректное значение')
        end
      end
    end
  end
end
