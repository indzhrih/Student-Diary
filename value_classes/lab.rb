module ValueClasses
  class Lab
    attr_accessor :name, :deadline, :status, :mark
    attr_reader :id, :discipline_id

    def initialize(id, name, deadline, status, mark, discipline_id)
      @id = id
      @name = name
      @deadline = deadline
      @status = status
      @mark = mark
      @discipline_id = discipline_id
    end

    class << self
      def get_labs_to_disciplines(discipline_id)
        result = DBConnect.read_query(
          'SELECT id, name, deadline, status, mark, discipline_id FROM lab WHERE discipline_id = $1', [discipline_id]
        )
        return [] if result.num_tuples.zero?

        labs = []
        result.each do |row|
          labs.push(Lab.new(row['id'].to_i, row['name'], row['deadline'], row['status'], row['mark'],
                            row['discipline_id']))
        end
        labs
      end
    end
  end
end
