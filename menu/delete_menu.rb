require_relative 'base_menu'

module Menu
  class DeleteMenu < BaseMenu
    class << self
    end
  end

  class << self
    def delete(message)
      DeleteMenu.perform(message)
    end
  end
end
