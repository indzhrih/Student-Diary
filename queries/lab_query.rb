require_relative 'base_query'
require_relative '../value_classes/lab'

module Queries
  class LabQuery < BaseQuery
    class << self
      def is_name_unique(name:)
        result = perform_query(query: 'SELECT name FROM lab WHERE name = $1', params: [name])

        return true if result.num_tuples.zero?

        false
      end

      def add_to_d_b(info:)
        name = info.name
        deadline = info.deadline
        completed = info.completed
        mark = info.mark
        discipline_id = info.discipline_id.to_i

        perform_query(query: 'INSERT INTO lab (name, deadline, completed, mark, discipline_id) VALUES ($1, $2, $3, $4, $5)',
                      params: [name, deadline, completed, mark, discipline_id.to_i])
      end
    end
  end
end
