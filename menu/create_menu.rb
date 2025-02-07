require_relative 'base_menu'

module Menu
  class CreateMenu < BaseMenu
    class << self
    end
  end

  class << self
    def create(message)
      CreateMenu.perform(message)
    end
  end
end
