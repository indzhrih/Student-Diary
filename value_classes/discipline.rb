require_relative 'lab'
require_relative '../query_objects/discipline_query'

module ValueClasses
  class Discipline
    attr_accessor :name, :marks, :labs

    def initialize(id:, name:, semester_id:)
      @id = id
      @name = name
      @semester_id = semester_id
    end

    def get_json_info
      {
        id: @id,
        name: @name,
        semester_id: @semester_id,
        labs: QueryObjects::DisciplineQuery.get_labs_to_disciplines(discipline_id: @id)
      }
    end
  end
end
