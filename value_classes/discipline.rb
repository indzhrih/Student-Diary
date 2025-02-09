require_relative 'lab'
require 'query_objects/discipline_query'

module ValueClasses
  class Discipline
    attr_accessor :name, :marks, :labs

    def initialize(id = 1, name = '', semester_id = 1)
      @id = id
      @name = name
      @semester_id = semester_id
    end

    def get_json_info
      {
        id: @id,
        name: @name,
        semester_id: @semester_id,
        labs: QueryObjects::DisciplineQuery.get_labs_to_disciplines(@id)
      }
    end
  end
end
