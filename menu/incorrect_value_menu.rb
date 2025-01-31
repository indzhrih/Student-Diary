require_relative 'base_menu'

module Menu
  class IncorrectValueMenu < BaseMenu
    def self.perform(message)
      super(message)
    end
  end

  def self.warning(message)
    IncorrectValueMenu.perform(message)
  end
end
