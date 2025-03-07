require_relative 'dialog'

module Menu
  class BaseMenu
    def initialize
      @choice = 0
    end

    class << self
      def perform(message:)
        puts message
        Dialog.new.start_dialog
      end

      def get_variants_string(table_name:)
        "Введите название из таблицы #{table_name}, или 0 если хотите вернуться назад\n"\
               "Добавленные объекты из #{table_name}:\n"
      end

      def get_name(message: nil)
        puts message if message.nil? == false
        @choice = gets.chomp

        return Menu.start if @choice == '0'

        @choice
      end

      def object_check(object:, choice:)
        return object if object.nil? == false

        Menu.warning(message: 'Пожалуйста введите корректное значение', choice: choice)
      end
    end
  end
end
