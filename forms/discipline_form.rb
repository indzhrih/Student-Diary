# frozen_string_literal: true

require_relative '../queries/discipline_query'
require_relative '../menu/create_menu'

module Forms
  class DisciplineForm
    class << self
      def create_discipline(sem_id:)
        Queries::DisciplineQuery.add_to_d_b(sem_id: sem_id, name: validate_name)
      end

      private

      def validate_name
        puts 'Введите название дисциплины'
        name = gets.chomp
        while name.empty?
          puts 'Имя не может быть пустым!'
          name = gets.chomp
        end
        name
      end
    end
  end
end
