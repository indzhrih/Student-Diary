require_relative 'base_query'
require_relative '../value_classes/lab'

module Queries
  class LabQuery < BaseQuery
    class << self
      def find_lab_by_name_and_discipline_id(lab:, discipline_id:)
        result = perform_query(query: 'SELECT * FROM lab WHERE name = $1 AND discipline_id = $2',
                               params: [lab, discipline_id])
        return nil if result.num_tuples.zero?

        translate_row(row: result.first, table_type: :lab)
      end

      def add_to_d_b(lab:)
        perform_query(query: 'INSERT INTO lab (name, deadline, completed, mark, discipline_id) VALUES ($1, $2, $3, $4, $5)',
                      params: lab)
      end
    end
  end
end
