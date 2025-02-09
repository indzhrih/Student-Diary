require_relative 'dialog'

module Menu
  class << self
    def start
      Dialog.new.start_dialog
    end

    def show
      ShowMenu.perform
    end

    def create(message)
      CreateMenu.perform(message)
    end

    def delete(message)
      DeleteMenu.perform(message)
    end

    def exit_application(message)
      ExitMenu.perform(message)
    end

    def warning(message, choice)
      IncorrectValueMenu.perform(message, choice)
    end
  end
end
