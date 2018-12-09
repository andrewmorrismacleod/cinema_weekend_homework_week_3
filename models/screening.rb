require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time, :price, :number_of_tickets

  def initialize(options)
    @id = options['id'] if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time']
    @price = options['price'].to_i
    @number_of_tickets = options['number_of_tickets'].to_i
  end

  def save
    sql = "INSERT INTO screenings (film_id, screening_time, price, number_of_tickets) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @screening_time, @price, @number_of_tickets]
    hash_array = SqlRunner.run(sql, values)
    @id = hash_array[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    hash_array = SqlRunner.run(sql, values)
    return Screening.new(hash_array.first)
  end

  def update
    sql = "UPDATE screenings SET (film_id, screening_time, price, number_of_tickets) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@film_id, @screening_time, @price, @number_of_tickets, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
      sql = "DELETE FROM screenings WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
  end

end
