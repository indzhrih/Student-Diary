require_relative 'base_menu'

module Menu
  class CreateMenu < BaseMenu
    def self.perform(message)
      super(message)
    end
  end

  def self.create(message)
    CreateMenu.perform(message)
  end
end
