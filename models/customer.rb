require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    hash_array = SqlRunner.run(sql, values)
    @id = hash_array[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    hash_array = SqlRunner.run(sql, values)
    return Customer.new(hash_array.first)
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
      sql = "DELETE FROM customers WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
  end

  def films
    sql = "SELECT films.* FROM films
            INNER JOIN screenings
            ON films.id = screenings.film_id
            INNER JOIN tickets
            ON tickets.screening_id = screenings.id
            WHERE customer_id = $1
            "

    values = [@id]
    hash_array = SqlRunner.run(sql, values)
    return hash_array.map {|film| Film.new(film)}
  end


  def tickets_count_sql
    sql = "SELECT COUNT(customer_id) FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    hash_array = SqlRunner.run(sql, values)
    return hash_array.first['count'].to_i
  end

  def tickets_count_ruby
    return films.count
  end

  def buy_ticket(screening)
    if can_afford_ticket?(screening) && ticket_available?(screening)
      @funds -= screening.price
      ticket_hash = {'customer_id' => @id, 'screening_id' => screening.id}
      ticket = Ticket.new(ticket_hash)
      ticket.save
      screening.number_of_tickets -= 1
      screening.update
      self.update
    end
  end

  def can_afford_ticket?(screening)
    return screening.price<= @funds
  end

  def ticket_available?(screening)
    return screening.number_of_tickets>0
  end

end
