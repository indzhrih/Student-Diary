require_relative '../queries/discipline_query'

module Commands
  class DeleteDiscipline
    class << self
      def delete_discipline(discipline_id:)
        Queries::DisciplineQuery.delete_discipline_from_d_b(discipline_id: discipline_id)
      end
    end
  end
end