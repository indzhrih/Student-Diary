require_relative 'base_query'
require_relative '../value_classes/lab'

module Queries
  class LabQuery < BaseQuery
    class << self
      def add_to_d_b(lab:)
        perform_query(query: 'INSERT INTO lab (name, deadline, completed, mark, discipline_id) VALUES ($1, $2, $3, $4, $5)',
                      params: lab)
      end
    end
  end
end
