require_relative 'base_menu'

module Menu
  class ExitMenu < BaseMenu
    class << self
      def perform(message)
        puts(message)
        exit
      end
    end
  end

  class << self
    def exit_application(message)
      ExitMenu.perform(message)
    end
  end
end
