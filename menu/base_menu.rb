require_relative 'dialog'

module Menu
  class BaseMenu
    def self.perform(message)
      puts message
      Dialog.new.start_dialog
    end
  end
end
