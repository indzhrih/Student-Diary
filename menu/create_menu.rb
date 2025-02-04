require_relative 'base_menu'

module Menu
  class CreateMenu < BaseMenu
  end

  def self.create(message)
    CreateMenu.perform(message)
  end
end
