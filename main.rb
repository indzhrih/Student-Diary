require_relative 'd_b_connect'
require_relative 'menu/main_menu'

DatabaseConnect.new.initialize_database
Menu.start
