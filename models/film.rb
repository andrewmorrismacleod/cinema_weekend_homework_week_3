require_relative('../db/sql_runner')
require_relative('customer')

class Film

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def save
    sql = "INSERT INTO films (title, genre) VALUES ($1, $2) RETURNING id"
    values = [@title, @genre]
    hash_array = SqlRunner.run(sql, values)
    @id = hash_array[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    hash_array = SqlRunner.run(sql, values)
    return Film.new(hash_array.first)
  end

  def update
    sql = "UPDATE films SET (title, genre) = ($1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
      sql = "DELETE FROM films WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
  end

  def customers
      sql  = "SELECT customers.* FROM customers
              INNER JOIN tickets
              ON customers.id = tickets.customer_id
              INNER JOIN screenings
              ON tickets.screening_id = screenings.id
              WHERE film_id = $1"

      values = [@id]
      hash_array = SqlRunner.run(sql, values)
      return hash_array.map { |customer| Customer.new(customer)}
  end

  def customers_count_sql
      sql = "SELECT COUNT(film_id) FROM tickets
              INNER JOIN screenings
              on tickets.screening_id = screenings.id
              WHERE film_id = $1"
      values = [@id]
      hash_array = SqlRunner.run(sql, values)
      return hash_array.first['count'].to_i
  end

  # Utilises the customers function defined earlier
  def customers_count_ruby
    return customers.count
  end

  def most_popular_screening()
    sql  = "SELECT screening_temp.screening_id, COUNT(screening_temp.screening_id)

        		FROM
        			(SELECT tickets.screening_id, screenings.film_id, films.title FROM tickets
                  		INNER JOIN screenings ON
                  		tickets.screening_id = screenings.id
                  		INNER JOIN films ON
                  		screenings.film_id = films.id
                  		WHERE films.id = $1
                  ) AS screening_temp

          	GROUP BY screening_temp.screening_id
          	ORDER BY screening_temp.count DESC
          	LIMIT 1	"

    values = [@id]
    hash_array = SqlRunner.run(sql, values)
    screening_id = hash_array.first['screening_id'].to_i
    return Screening.find_by_id(screening_id)
  end


end
