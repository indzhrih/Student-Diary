require_relative 'dialog'

module Menu
  class << self
    def start
      Dialog.new.start_dialog
    end
  end
end
