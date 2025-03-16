require_relative 'base_query'
require_relative '../value_classes/semester'

module Queries
  class SemesterQuery < BaseQuery
    class << self
      def find_sem_by_name_or_id(sem_name: nil, sem_id: nil)
        result = perform_query(query: 'SELECT * FROM semester WHERE name = $1', params: [sem_name]) if sem_name
        result = perform_query(query: 'SELECT * FROM semester WHERE id = $1', params: [sem_id]) if sem_id

        return nil if result.num_tuples.zero?

        convert_row_to_object(row: result.first, table_type: :semester)
      end

      def get_sem_data
        result = perform_query(query: 'SELECT * FROM semester')
        result.map { |row| convert_row_to_object(row: row, table_type: :semester) }
      end

      def show_added_sems
        result = perform_query(query: 'SELECT name FROM semester')
        result.map { |row| puts(row['name']) }
      end

      def show_disciplines_for_sem(sem_id:)
        result = perform_query(query: 'SELECT name FROM discipline WHERE semester_id = $1', params: [sem_id])
        result.map { |row| puts(row['name']) }
      end

      def get_disciplines_to_sem(sem_id:)
        result = perform_query(
          query: 'SELECT * FROM discipline WHERE semester_id = $1', params: [sem_id]
        )

        return [] if result.num_tuples.zero?

        result.map { |row| convert_row_to_object(row: row, table_type: :discipline) }
      end

      def is_name_unique(name:)
        perform_query(query: 'SELECT name FROM semester WHERE name = $1', params: [name]).num_tuples.zero?
      end

      def add_to_d_b(sem:)
        perform_query(query: 'INSERT INTO semester (name, start_date, end_date, active) VALUES ($1, $2, $3, $4)',
                      params: sem)
      end
    end
  end
end
