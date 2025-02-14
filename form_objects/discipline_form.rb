require_relative '../query_objects/discipline_query'
require_relative '../menu/create_menu'

module FormObjects
  class DisciplineForm
    class << self
      def create_discipline(sem_id:)
        QueryObjects::DisciplineQuery.add_to_d_b(sem_id: sem_id, name: get_discipline_name)
        Menu::CreateMenu.perform
      end

      private

      def get_discipline_name
        puts 'Введите название дисциплины'
        gets.chomp
      end
    end
  end
end
