require 'pg'

class DBConnect
  class << self
    def initialize_database(sql_file, dbname)
      create_database(dbname)
      fill_database(sql_file)
    end

    def get_connection
      PG.connect(host: 'localhost', port: 5432, dbname: 'student_diary', user: 'devuser', password: 'strongpassw0rd')
    end

    def read_query(query, params = [])
      connection = get_connection
      result = connection.exec_params(query, params)
      result
    rescue PG::Error => e
      puts "Ошибка запроса на чтение: #{e.message}"
      nil
    ensure
      connection.close
    end

    private

    def create_database(dbname)
      connection = get_connection
      result = connection.exec_params('SELECT 1 FROM pg_database WHERE datname = $1', [dbname])
      db_exists = result.num_tuples.positive?

      connection.exec("CREATE DATABASE #{dbname}") if db_exists == false
    rescue PG::Error => e
      puts "Ошибка при создании/проверке базы данных: #{e.message}"
    ensure
      connection.close
    end

    def fill_database(sql_file)
      connection = get_connection
      connection.exec(File.read(sql_file))
    rescue PG::Error => e
      puts "Ошибка при выполнении SQL: #{e.message}"
    ensure
      connection.close
    end
  end
end
