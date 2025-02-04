require_relative 'semestr'

module ValueClasses
  class Sems
    attr_accessor :semestrs

    def initialize
      @semestrs = []
    end

    def show_sems
      if @semestrs.empty?
        puts 'Нет семестров'
      else
        puts @semestrs.map(&:name).join(', ')
      end
    end

    def find_sem(name)
      @semestrs.find { |sem| sem.name == name }
    end
  end

  SEMS = Sems.new
end
