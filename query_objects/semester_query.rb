require_relative 'query_object'
require 'value_classes/semester'

module QueryObjects
  class SemesterQuery < QueryObject
    class << self
      def find_sem(sem = '')
        result = perform_read_query(
          'SELECT * FROM semester WHERE name = $1', [sem]
        )
        return nil if result.num_tuples.zero?

        row = result.first
        ValueClasses::Semester.new(row['id'].to_i, row['name'], row['start_date'], row['end_date'], row['active'])
      end

      def show_added_sems
        result = perform_read_query('SELECT name FROM semester')
        result.map { |row| puts(row['name']) }
      end

      def get_disciplines_to_sem(sem_id = 1)
        result = QueryObject.perform_read_query(
          'SELECT * FROM discipline WHERE semester_id = $1', [sem_id]
        )
        return [] if result.num_tuples.zero?

        disciplines = []
        result.each do |row|
          disciplines.push(ValueClasses::Discipline.new(row['id'].to_i, row['name'], row['semester_id']))
        end
        disciplines
      end
    end
  end
end
