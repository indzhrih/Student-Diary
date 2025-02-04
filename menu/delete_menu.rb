require_relative 'base_menu'

module Menu
  class DeleteMenu < BaseMenu
  end

  def self.delete(message)
    DeleteMenu.perform(message)
  end
end
