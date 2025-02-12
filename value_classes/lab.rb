module ValueClasses
  class Lab
    attr_accessor :name, :deadline, :completed, :mark

    def initialize(id:, name:, deadline:, mark:, discipline_id:, completed: false)
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
