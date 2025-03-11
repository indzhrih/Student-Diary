require_relative '../d_b_connect'
require 'pg'

module Queries
  class BaseQuery
    class << self
      def perform_query(query:, params: [])
        connection = DatabaseConnect.new.connection
        result = connection.exec_params(query, params)

        result
      rescue PG::Error => e
        puts "Ошибка запроса на чтение: #{e.message}"

        nil
      ensure
        connection.close
      end

      private 
      
      def convert_row_to_object(row:, table_type:)
        case table_type
        when :semester
          ValueClasses::Semester.new(id: row['id'].to_i, name: row['name'], start_date: row['start_date'],
                                     end_date: row['end_date'], active: row['active'])
        when :discipline
          ValueClasses::Discipline.new(id: row['id'].to_i, name: row['name'],
                                       semester_id: row['semester_id'])
        when :lab
          ValueClasses::Lab.new(id: row['id'].to_i, name: row['name'], deadline: row['deadline'],
                                completed: row['completed'], mark: ['mark'], discipline_id: row['discipline_id'])
        end
      end
    end
  end
end
