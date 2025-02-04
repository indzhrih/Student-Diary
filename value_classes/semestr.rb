require_relative 'discipline'

module ValueClasses
  class Semestr
    attr_accessor :name, :start_date, :end_date, :is_active, :disciplines

    def initialize(name = '', start_date = '', end_date = '', is_active = '', disciplines = [])
      @name = name
      @start_date = start_date
      @end_date = end_date
      @is_active = is_active
      @disciplines = disciplines
    end

    def output
      puts "Семестр: #{@name}\n"\
           "- Дата начала: #{@start_date}\n"\
           "- Дата окончания: #{@end_date}\n"\
           "- Статус: #{@is_active}\n"\
           "--------------------------\n"
      if @disciplines.empty?
        puts 'Дисциплины не добавлены'
      else
        @disciplines.each(&:output)
      end
    end

    def show_disciplines
      if @disciplines.empty?
        puts 'Вы еще не добавили дисциплины в этот семестр'
      else
        @disciplines.each(&:output)
      end
    end
  end
end
