# frozen_string_literal: true

require_relative '../queries/base_query'

module Commands
  class DeleteCommand
    def self.perform(object:, object_type:)
      return Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 4) if object.nil?

      Queries::BaseQuery.perform_query(
        query: "DELETE FROM #{object_type} WHERE id IN ($1)",
        params: [object.get_json_info[:id]]
      )
    end
  end
end
