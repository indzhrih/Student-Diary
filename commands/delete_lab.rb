require_relative '../queries/lab_query'

module Commands
  class DeleteLab
    class << self
      def delete_lab(lab_id:)
        Queries::LabQuery.delete_lab_from_d_b(lab_id: lab_id)
      end
    end
  end
end