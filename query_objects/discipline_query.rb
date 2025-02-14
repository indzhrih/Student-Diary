require_relative 'base_query'
require_relative '../value_classes/discipline'

module QueryObjects
  class DisciplineQuery < BaseQuery
    class << self
      def find_discipline_by_sem_id(discipline:, sem_id:)
        result = perform_query(query: 'SELECT * FROM discipline WHERE name = $1 AND semester_id = $2',
                               params: [discipline, sem_id])
        return nil if result.num_tuples.zero?

        row = result.first
        ValueClasses::Discipline.new(id: row['id'].to_i, name: row['name'], semester_id: row['semester_id'])
      end

      def get_labs_to_disciplines(discipline_id:)
        result = perform_query(
          query: 'SELECT * FROM lab WHERE discipline_id = $1', params: [discipline_id]
        )
        return [] if result.num_tuples.zero?

        result.map do |row|
          ValueClasses::Lab.new(id: row['id'].to_i, name: row['name'], deadline: row['deadline'], completed: row['completed'], mark: row['mark'],
                                discipline_id: row['discipline_id'])
        end
      end

      def show_added_disciplines_by_id(sem_id:)
        result = perform_query(query: 'SELECT name FROM discipline WHERE semester_id = $1', params: [sem_id])
        result.map { |row| puts(row['name']) }
      end

      def add_to_d_b(sem_id:, name:)
        perform_query(query: 'INSERT INTO discipline (name, semester_id) VALUES ($1, $2)',
                      params: [name, sem_id])
      end
    end
  end
end
