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
        when 3
          CreateMenu.perform
        when 4
          DeleteMenu.perform
        when 5
          CSVExportMenu.perform
        end
      end
    end
  end
end
