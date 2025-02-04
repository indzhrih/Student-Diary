require_relative 'dialog'

module Menu
  class << self
    def start
      Dialog.new.start_dialog
    end

    def show
      ShowMenu.perform
    end

    def create(message:)
      CreateMenu.perform(message: message)
    end

    def delete(message:)
      DeleteMenu.perform(message: message)
    end

    def exit_application(message:)
      ExitMenu.perform(message: message)
    end

    def warning(message:, choice:)
      IncorrectValueMenu.perform(message: message, choice: choice)
    end
  end
end
