require_relative 'discipline'
require 'db_connect'

module ValueClasses
  class Semester
    attr_accessor :name, :start_date, :end_date, :is_active
    attr_reader :id

    def initialize(id, name, start_date, end_date, is_active)
      @id = id
      @name = name
      @start_date = start_date
      @end_date = end_date
      @is_active = is_active
    end

    class << self
      def find_sem(sem)
        result = DBConnect.read_query('SELECT id, name, start_date, end_date FROM semester WHERE name = $1', [sem])
        return nil if result.num_tuples.zero?

        row = result.first
        Semester.new(row['id'].to_i, row['name'], row['start_date'], row['end_date'], row['status'])
      end

      def show_added
        result = DBConnect.read_query('SELECT name FROM semester')
        result.map { |row| puts(row['name']) }
      end
    end
  end
end
