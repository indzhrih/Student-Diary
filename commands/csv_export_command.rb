require 'csv'
require_relative '../queries/base_query'

module Commands
  class CSVExprotCommand
    class << self
      def export_table(table_name:)
        data = []
        case table_name
        when :semester
          Queries::BaseQuery.perform_query(query: 'SELECT * FROM semester').map do |sem|
            data.push([sem['id'], sem['name'], sem['start_date'], sem['end_date'], sem['active']])
          end
        when :discipline
          Queries::BaseQuery.perform_query(query: 'SELECT * FROM discipline').map do |discipline|
            data.push([discipline['id'], discipline['name'], discipline['semester_id']])
          end
        when :lab
          Queries::BaseQuery.perform_query(query: 'SELECT * FROM lab').map do |lab|
            data.push([lab['id'], lab['name'], lab['deadline'], lab['completed'], lab['mark'], lab['discipline_id']])
          end
        end

        CSV.open("#{table_name}_csv_file.csv", 'w') do |csv|
          data.each { |row| csv << row }
        end
      end
    end
  end
end
