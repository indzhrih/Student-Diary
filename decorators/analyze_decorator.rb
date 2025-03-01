require_relative '../queries/semester_query'
require_relative '../menu/base_menu'

module Decorators
  class AnalyzeDecorator
    class << self
      def analyze_data_by_type(show_type:)
        case show_type
        when 1
          show_by_name
        when 2
          show_active
        when 3
          show_by_discipline
        when 4
          show_by_end_date
        when 5
          show_by_average_grade
        end
      end

      private

      def show_by_name
        puts 'Добавленные семестры'
        Queries::SemesterQuery.show_added_sems

        [*Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: Menu::BaseMenu::get_name)]
      end

      def show_active
        Queries::SemesterQuery.get_sem_data.select { |sem| sem.active }
      end

      def show_by_discipline
        name = Menu::BaseMenu.get_name 

        Queries::SemesterQuery.get_sem_data.select! do |sem|
          sem.get_json_info[:disciplines].any? { |discipline| discipline.get_json_info[:name] == name }
        end
      end

      def show_by_end_date
        Queries::SemesterQuery.get_sem_data.sort_by { |sem| Date.strptime(sem.get_json_info[:end_date], "%Y-%m-%d") }
      end

      def show_by_average_grade
        Queries::SemesterQuery.get_sem_data.each do |sem|
          sem.get_json_info[:disciplines].sort_by { |discipline| 
            marks = discipline.get_json_info[:labs].map { |lab| lab.get_json_info[:mark].to_i }
            marks.sum.to_f / marks.size
          }
        end
      end
    end
  end
end
