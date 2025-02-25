require_relative '../queries/base_query'

module Commands
  class DeleteCommand
    def self.perform(object:, object_type:)
      return unless object.nil? == false

      Queries::BaseQuery.perform_query(
        query: "DELETE FROM #{object_type} WHERE id IN ($1)",
        params: [object.get_json_info[:id]]
      )
    end
  end
end
