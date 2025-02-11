require 'pg'
require 'dotenv'
Dotenv.load

class DatabaseConnect
  attr_accessor :connection

  def initialize(host: ENV['DB_HOST'], port: ENV['DB_PORT'].to_i, dbname: ENV['DB_NAME'], user: ENV['DB_USER'],
                 password: ENV['DB_PASSWORD'])
    @connection = PG.connect(
      host: host,
      port: port,
      dbname: dbname,
      user: user,
      password: password
    )
  end

  def initialize_database
    create_database
    fill_database
    @connection.close
  end

  private

  def create_database(dbname: ENV['DB_NAME'])
    result = @connection.exec_params('SELECT 1 FROM pg_database WHERE datname = $1', [dbname])
    db_exists = result.num_tuples.positive?

    @connection.exec("CREATE DATABASE #{dbname}") if db_exists == false
  rescue PG::Error => e
    puts "Ошибка при создании/проверке базы данных: #{e.message}"
  end

  def fill_database(sql_file: 'db_initialization.sql')
    @connection.exec(File.read(sql_file))
  rescue PG::Error => e
    puts "Ошибка при выполнении SQL: #{e.message}"
  end
end
