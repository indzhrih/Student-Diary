require_relative '../queries/semester_query'

module Commands
  class DeleteSemester
    class << self
      def delete_semester(sem_name:)
        Queries::SemesterQuery.delete_sem_from_d_b(sem_name: sem_name)
      end
    end
  end
end
