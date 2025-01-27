require_relative 'base_menu'

module Menu
  class DeleteMenu < BaseMenu
    def self.perform(message)
      super(message)
    end
  end

  def self.delete(message)
    DeleteMenu.perform(message)
  end
end
