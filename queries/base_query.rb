require_relative '../d_b_connect'
require 'pg'

module Queries
  class BaseQuery
    class << self
      def perform_query(query:, params: [])
        connection = DatabaseConnect.new.connection
        result = connection.exec_params(query, params)

        result
      rescue PG::Error => e
        puts "Ошибка запроса на чтение: #{e.message}"

        nil
      ensure
        connection.close
      end
    end
  end
end
