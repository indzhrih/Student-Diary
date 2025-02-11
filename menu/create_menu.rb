require_relative 'base_menu'

module Menu
  class CreateMenu < BaseMenu
    class << self
      def self.perform(message:)
        super(message: message)
      end
    end
  end
end
