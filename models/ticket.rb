require_relative('../db/sql_runner')
require_relative('screening')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id

  def initialize(options)
    @id = options['id'] if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id']
  end

  def save
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @screening_id]
    hash_array = SqlRunner.run(sql, values)
    @id = hash_array[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    hash_array = SqlRunner.run(sql, values)
    return Ticket.new(hash_array.first)
  end

  def update
    sql = "UPDATE tickets SET (customer_id, screening_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
      sql = "DELETE FROM tickets WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
  end




end
