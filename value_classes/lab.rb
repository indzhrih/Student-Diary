module ValueClasses
  class Lab
    attr_accessor :name, :deadline, :completed, :mark

    def initialize(name:, deadline:, mark:, discipline_id:, id:, completed: false)
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
        completed: @completed == 't' ? 'Выполнено' : 'Не Выполнено',
        mark: @mark,
        discipline_id: @discipline_id
      }
    end
  end
end
