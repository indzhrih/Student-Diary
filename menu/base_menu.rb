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

      def get_name
        puts 'Введите название семестра/дисципилины/лабораторной, или 0 если хотите вернуться назад'
        @choice = gets.chomp

        return Menu.start if @choice == '0'

        @choice
      end
    end
  end
end
