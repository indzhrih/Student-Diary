module ValueClasses
  class Lab
    attr_accessor :name

    def initialize(name = '', deadline = '', status = '', mark = 0)
      @name = name
      @deadline = deadline
      @status = status
      @mark = mark
    end

    def output
      puts "    [#{@status}] #{@name}"
      if @status == 'Completed'
        puts "    Grade: #{@mark}"
      else
        puts "    Deadline: #{@deadline}"
      end
    end
  end
end
