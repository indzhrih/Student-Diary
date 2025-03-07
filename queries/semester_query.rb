require_relative 'base_query'
require_relative '../value_classes/semester'

module Queries
  class SemesterQuery < BaseQuery
    class << self
      def find_sem_by_name_or_id(sem_name: nil, sem_id: nil)
        result = perform_query(query: 'SELECT * FROM semester WHERE name = $1', params: [sem_name]) if sem_name
        result = perform_query(query: 'SELECT * FROM semester WHERE id = $1', params: [sem_id]) if sem_id

        return nil if result.num_tuples.zero?

        row = result.first
        ValueClasses::Semester.new(id: row['id'].to_i, name: row['name'], start_date: row['start_date'],
                                   end_date: row['end_date'], active: row['active'])
      end

      def get_sem_data
        result = perform_query(query: 'SELECT * FROM semester')
        result.map do |row|
          ValueClasses::Semester.new(id: row['id'].to_i, name: row['name'], start_date: row['start_date'],
                                     end_date: row['end_date'], active: row['active'])
        end
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

        result.map do |row|
          ValueClasses::Discipline.new(id: row['id'].to_i, name: row['name'],
                                       semester_id: row['semester_id'])
        end
      end

      def is_name_unique(name:)
        result = perform_query(query: 'SELECT name FROM semester WHERE name = $1', params: [name])

        return true if result.num_tuples.zero?

        false
      end

      def add_to_d_b(sem:)
        perform_query(query: 'INSERT INTO semester (name, start_date, end_date, active) VALUES ($1, $2, $3, $4)',
                      params: sem)
      end
    end
  end
end
