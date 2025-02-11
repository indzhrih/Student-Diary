require_relative 'base_menu'
require_relative 'show_menu'

module Menu
  class IncorrectValueMenu < BaseMenu
    class << self
      def perform(message:, choice:)
        puts message
        case choice
        when 1
          Dialog.new.start_dialog
        when 2
          ShowMenu.perform
        end
      end
    end
  end
end
