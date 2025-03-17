# frozen_string_literal: true

require_relative 'base_menu'

module Menu
  class ExitMenu < BaseMenu
    class << self
      def perform(message:)
        puts(message)
        exit
      end
    end
  end
end
