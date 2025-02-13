require_relative 'discipline'
require_relative '../query_objects/semester_query'
require_relative '../d_b_connect'

module ValueClasses
  class Semester
    attr_accessor :name, :start_date, :end_date, :active

    def initialize(id:, name:, start_date:, end_date:, active: false)
      @id = id
      @name = name
      @start_date = start_date
      @end_date = end_date
      @active = active
    end

    def get_json_info
      {
        id: @id,
        name: @name,
        start_date: @start_date,
        end_date: @end_date,
        active: @active ? 'Активен' : 'Не активен',
        disciplines: QueryObjects::SemesterQuery.get_disciplines_to_sem(sem_id: @id)
      }
    end
  end
end
