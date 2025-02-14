require_relative 'base_query'
require_relative '../value_classes/semester'

module QueryObjects
  class SemesterQuery < BaseQuery
    class << self
      def find_sem_by_name(sem_name:)
        result = perform_query(query: 'SELECT * FROM semester WHERE name = $1', params: [sem_name])
        return nil if result.num_tuples.zero?

        row = result.first
        ValueClasses::Semester.new(id: row['id'].to_i, name: row['name'], start_date: row['start_date'],
                                   end_date: row['end_date'], active: row['active'])
      end

      def find_sem_by_id(sem_id:)
        result = perform_query(query: 'SELECT * FROM semester WHERE id = $1', params: [sem_id])
        return nil if result.num_tuples.zero?

        row = result.first
        ValueClasses::Semester.new(id: row['id'].to_i, name: row['name'], start_date: row['start_date'],
                                   end_date: row['end_date'], active: row['active'])
      end

      def show_added_sems
        result = perform_query(query: 'SELECT name FROM semester')
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

      def add_to_d_b(info:)
        perform_query(query: 'INSERT INTO semester (name, start_date, end_date, active) VALUES ($1, $2, $3, $4)',
                      params: [info[:name], info[:start_date], info[:end_date], info[:active]])
      end
    end
  end
end
