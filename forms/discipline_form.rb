require_relative '../queries/discipline_query'
require_relative '../menu/create_menu'

module Forms
  class DisciplineForm
    class << self
      def create_discipline(sem_id:)
        Queries::DisciplineQuery.add_to_d_b(sem_id: sem_id, name: get_name)
      end

      private

      def get_name
        puts 'Введите название дисциплины'

        gets.chomp
      end
    end
  end
end
