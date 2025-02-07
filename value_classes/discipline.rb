require_relative 'lab'

module ValueClasses
  class Discipline
    attr_accessor :name, :marks, :labs
    attr_reader :id, :semester_id

    def initialize(id, name, semester_id)
      @id = id
      @name = name
      @semester_id = semester_id
    end

    class << self
      def get_disciplines_to_sem(sem_id)
        result = DBConnect.read_query('SELECT id, name, semester_id FROM discipline WHERE semester_id = $1', [sem_id])
        return [] if result.num_tuples.zero?

        disciplines = []
        result.each do |row|
          disciplines.push(Discipline.new(row['id'].to_i, row['name'], row['semester_id']))
        end
        disciplines
      end
    end
  end
end
