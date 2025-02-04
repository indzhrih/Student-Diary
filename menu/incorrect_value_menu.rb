require_relative 'base_menu'

module Menu
  class IncorrectValueMenu < BaseMenu
  end

  def self.warning(message)
    IncorrectValueMenu.perform(message)
  end
end
