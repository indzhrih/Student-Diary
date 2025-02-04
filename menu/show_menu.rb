require_relative 'base_menu'
require_relative 'dialog'
require_relative '../value_classes/sems'

module Menu
  class ShowMenu < BaseMenu
    include ValueClasses

    def initialize
      @choice = ''
    end

    def self.perform
      variants
      choice_menu
    end

    def self.variants
      puts "Введите название семестра, который хотите отобразить или 0 если хотите вернуться назад \n"\
           "Добавленные семестры:\n"
      SEMS.show_sems
    end

    def self.choice_menu
      @choice = gets.chomp
      chosen_sem = SEMS.find_sem(@choice)
      if !chosen_sem.nil?
        show_sem(chosen_sem)
      elsif @choice.chomp == '0'
        puts 'Назад...'
        Menu.start
      else
        warning
      end
    end

    def self.show_sem(sem)
      sem.output
      perform
    end

    def self.warning
      puts "Указанный семестр не найден!\n"\
           'Пожалуйста введите корректное значение'
      perform
    end
  end

  def self.show
    ShowMenu.perform
  end
end
