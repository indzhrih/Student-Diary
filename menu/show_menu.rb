require_relative 'base_menu'
require_relative 'dialog'

module Menu
  class ShowMenu < BaseMenu
    def self.preform(message)
      super(message)
    end
  end

  def self.show(message)
    ShowMenu.perform(message)
  end
end
