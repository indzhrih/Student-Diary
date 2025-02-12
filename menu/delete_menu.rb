require_relative 'base_menu'

module Menu
  class DeleteMenu < BaseMenu
    class << self
      def perform(message:)
        super(message: message)
      end
    end
  end
end
