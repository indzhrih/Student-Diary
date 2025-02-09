module ValueClasses
  class Lab
    attr_accessor :name, :deadline, :completed, :mark

    def initialize(id = 1, name = '', deadline = '', completed = false, mark = 1, discipline_id = 1)
      @id = id
      @name = name
      @deadline = deadline
      @completed = completed
      @mark = mark
      @discipline_id = discipline_id
    end

    def get_json_info
      {
        id: @id,
        name: @name,
        deadline: @deadline,
        completed: @completed ? 'Выполнено' : 'Не Выполнено',
        mark: @mark,
        discipline_id: @discipline_id
      }
    end
  end
end
