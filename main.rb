$LOAD_PATH.unshift(File.expand_path(__dir__))

require 'db_connect'
require_relative 'menu/main_menu'

DBConnect.initialize_database('db_initialization.sql', 'student_diary')
Menu.start
