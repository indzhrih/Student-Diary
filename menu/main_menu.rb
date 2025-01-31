require_relative 'dialog'

module Menu
  def self.start
    Dialog.new.start_dialog
  end
end
