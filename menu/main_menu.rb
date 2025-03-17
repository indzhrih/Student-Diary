# frozen_string_literal: true

require_relative 'dialog'
require_relative 'csv_export_menu'

module Menu
  class << self
    def start
      Dialog.new.start_dialog
    end

    def show
      ShowMenu.perform
    end

    def create
      CreateMenu.perform
    end

    def delete
      DeleteMenu.perform
    end

    def csv_export
      CSVExportMenu.perform
    end

    def exit_application(message:)
      ExitMenu.perform(message: message)
    end

    def warning(message:, choice:)
      IncorrectValueMenu.perform(message: message, choice: choice)
    end
  end
end
