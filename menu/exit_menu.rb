require_relative 'base_menu'

module Menu
  class ExitMenu < BaseMenu
    def self.perform(message)
      puts(message)
      exit
    end
  end

  def self.exit_application(message)
    ExitMenu.perform(message)
  end
end
