require_relative 'base_query'
require_relative '../value_classes/lab'

module QueryObjects
  class LabQuery < BaseQuery
    class << self
      def add_to_d_b(discipline_id:, info:)
        perform_query(query: 'INSERT INTO lab (name, deadline, completed, mark, discipline_id) VALUES ($1, $2, $3, $4, $5)',
                      params: [info[:name], info[:deadline], info[:status], info[:mark], discipline_id.to_i])
      end
    end
  end
end
