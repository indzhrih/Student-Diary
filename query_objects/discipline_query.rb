require_relative 'base_query'
require_relative '../value_classes/discipline'

module QueryObjects
  class DisciplineQuery < BaseQuery
    class << self
      def get_labs_to_disciplines(discipline_id:)
        result = perform_read_query(
          query: 'SELECT * FROM lab WHERE discipline_id = $1', params: [discipline_id]
        )
        return [] if result.num_tuples.zero?

        result.map do |row|
          ValueClasses::Lab.new(id: row['id'].to_i, name: row['name'], deadline: row['deadline'], completed: row['completed'], mark: row['mark'],
                                discipline_id: row['discipline_id'])
        end
      end
    end
  end
end
