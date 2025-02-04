require_relative 'lab'

module ValueClasses
  class Discipline
    attr_accessor :name

    def initialize(name = '', marks = [], labs = [])
      @name = name
      @marks = marks
      @labs = labs
    end

    def output
      puts "Предмет: #{@name}\n"\
           "- Оценки: #{@marks.join(', ')}\n"
      if @labs.empty?
        puts 'Лабараторные работы не добавлены'
      else
        @labs.each(&:output)
      end
      puts '--------------------------'
    end

    def show_labs
      if @labs.empty?
        puts 'Вы еще не добавили лабараторные в эту дисциплину'
      else
        @labs.each(&:output)
      end
    end
  end
end
