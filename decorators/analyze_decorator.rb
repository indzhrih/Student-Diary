require_relative '../queries/semester_query'
require_relative '../queries/base_query'
require_relative '../value_classes/semester'
require_relative '../menu/base_menu'

module Decorators
  class AnalyzeDecorator
    class << self
      def analyze_data_by_type(sort_type:)
        case sort_type
        when 1
          select_sem_by_name
        when 2
          select_active_semesters
        when 3
          select_semesters_by_discipline
        when 4
          sort_by_end_date
        when 5
          sort_by_average_grade
        else
          Menu.warning(message: 'Пожалуйста введите корректное значение', choice: 2)
        end
      end

      private

      def select_sem_by_name
        puts 'Добавленные семестры(введите 0, если хотите вернуться назад)'
        Queries::SemesterQuery.show_added_sems

        [*Queries::SemesterQuery.find_sem_by_name_or_id(sem_name: Menu::BaseMenu.get_name)]
      end

      def select_active_semesters
        Queries::SemesterQuery.get_sem_data.select { |sem| sem.get_json_info[:active] == 'Активен' }
      end

      def select_semesters_by_discipline
        name = Menu::BaseMenu.get_name(message: 'Введите название дисциплины(введите 0, если хотите вернуться назад)')
        query = <<-SQL
          SELECT
            s.id AS semester_id,
            s.name AS semester_name,
            s.start_date AS semester_start_date,
            s.end_date AS semester_end_date,
            s.active AS semester_active
          FROM
            semester s
          INNER JOIN
            discipline d ON s.id = d.semester_id
          WHERE
            d.name = '#{name}'
        SQL

        results = Queries::BaseQuery.perform_query(query: query)

        translate_query_to_semesters(results: results)
      end

      def sort_by_end_date
        Queries::SemesterQuery.get_sem_data.sort_by { |sem| Date.strptime(sem.get_json_info[:end_date], '%Y-%m-%d') }
      end

      def sort_by_average_grade
        query = <<-SQL
          SELECT
            s.id AS semester_id,
            s.name AS semester_name,
            s.start_date AS semester_start_date,
            s.end_date AS semester_end_date,
            s.active AS semester_active,
            COALESCE(AVG(l.mark), 0) AS average_mark
          FROM
            semester s
          LEFT JOIN
            discipline d ON s.id = d.semester_id
          LEFT JOIN
            lab l ON d.id = l.discipline_id
          GROUP BY
            s.id, s.name, s.start_date, s.end_date, s.active
          ORDER BY average_mark DESC
        SQL
        results = Queries::BaseQuery.perform_query(query: query)

        translate_query_to_semesters(results: results)
      end

      def translate_query_to_semesters(results:)
        results.map do |row|
          ValueClasses::Semester.new(name: row['semester_name'], start_date: row['semester_start_date'],
                                     end_date: row['semester_end_date'], id: row['semester_id'], active: row['semester_active'])
        end
      end
    end
  end
end
