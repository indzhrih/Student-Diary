require_relative 'base_menu'
require_relative 'show_menu'

module Menu
  class IncorrectValueMenu < BaseMenu
    class << self
      def perform(message, choice)
        puts message
        case choice
        when 1 then Dialog.new.start_dialog
        when 2 then ShowMenu.perform
        end
      end
    end
  end

  class << self
    def warning(message, choice)
      IncorrectValueMenu.perform(message, choice)
    end
  end
end
