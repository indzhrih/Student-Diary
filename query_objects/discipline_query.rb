require 'value_classes/discipline'

module QueryObjects
  class DisciplineQuery < QueryObject
    class << self
      def get_labs_to_disciplines(discipline_id = 1)
        result = QueryObject.perform_read_query(
          'SELECT * FROM lab WHERE discipline_id = $1', [discipline_id]
        )
        return [] if result.num_tuples.zero?

        labs = []
        result.each do |row|
          labs.push(ValueClasses::Lab.new(row['id'].to_i, row['name'], row['deadline'], row['completed'], row['mark'],
                                          row['discipline_id']))
        end
        labs
      end
    end
  end
end
