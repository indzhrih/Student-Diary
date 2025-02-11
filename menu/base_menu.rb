require_relative 'dialog'

module Menu
  class BaseMenu
    def initialize
      @choice = 0
    end

    class << self
      def perform(message:)
        puts message
        Dialog.new.start_dialog
      end
    end
  end
end
