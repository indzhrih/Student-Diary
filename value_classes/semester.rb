# frozen_string_literal: true

require_relative 'discipline'
require_relative '../queries/semester_query'
require_relative '../d_b_connect'

module ValueClasses
  class Semester
    attr_accessor :name, :start_date, :end_date, :active

    def initialize(name:, start_date:, end_date:, id:, active: false)
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
        active: @active == 't' ? 'Активен' : 'Не активен',
        disciplines: Queries::SemesterQuery.get_disciplines_to_sem(sem_id: @id)
      }
    end
  end
end
