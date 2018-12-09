require('pry')
require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')
require_relative('./db/sql_runner')


customer1_hash = {'name' => "Steve the customer",'funds' => 100}
customer2_hash = {'name' => "Fred the customer",'funds' => 20}
customer3_hash = {'name' => "Sarah the customer",'funds' => 10}
customer4_hash = {'name' => "Donna the customer",'funds' => 10}
customer5_hash = {'name' => "Harry the customer",'funds' => 1}

customer1 = Customer.new(customer1_hash)
customer1.save

customer2 = Customer.new(customer2_hash)
customer2.save

customer3 = Customer.new(customer3_hash)
customer3.save

customer4 = Customer.new(customer4_hash)
customer4.save

customer5 = Customer.new(customer5_hash)
customer5.save

customer2.name = "Freddy the customer"
customer2.update

customer5.delete

film1_hash = {'title' => "The Terminator",'genre' => 'Sci-fi'}
film2_hash = {'title' => "Interstellar",'genre' => 'Sci-fi'}
film3_hash = {'title' => "The Room",'genre' => 'Who knows?'}
film4_hash = {'title' => "Dark City",'genre' => 'Sci-fi/Mystery'}
film5_hash = {'title' => "Airplane",'genre' => 'Comedy'}

film1 = Film.new(film1_hash)
film1.save

film2 = Film.new(film2_hash)
film2.save

film3 = Film.new(film3_hash)
film3.save

film3.genre = 'Madness'
film3.update

film4 = Film.new(film4_hash)
film4.save

film5 = Film.new(film5_hash)
film5.save

film5.delete

screening1_hash = { 'film_id' => film1.id, 'screening_time' => "16:00", 'price' => 1, 'number_of_tickets' =>10}
screening2_hash = { 'film_id' => film1.id, 'screening_time' => "19:00", 'price' => 5, 'number_of_tickets' =>10}
screening3_hash = { 'film_id' => film1.id, 'screening_time' => "22:00", 'price' => 10, 'number_of_tickets' =>10}
screening4_hash = { 'film_id' => film2.id, 'screening_time' => "16:30", 'price' => 1, 'number_of_tickets' =>10}
screening5_hash = { 'film_id' => film2.id, 'screening_time' => "19:00", 'price' => 5, 'number_of_tickets' =>10}
screening6_hash = { 'film_id' => film2.id, 'screening_time' => "19:30", 'price' => 10, 'number_of_tickets' =>10}
screening7_hash = { 'film_id' => film3.id, 'screening_time' => "15:00", 'price' => 1, 'number_of_tickets' =>10}
screening8_hash = { 'film_id' => film3.id, 'screening_time' => "18:00", 'price' => 6, 'number_of_tickets' =>10}
screening9_hash = { 'film_id' => film3.id, 'screening_time' => "21:00", 'price' => 12, 'number_of_tickets' =>10}
screening10_hash = { 'film_id' => film4.id, 'screening_time' => "15:00", 'price' => 3, 'number_of_tickets' =>10}
screening11_hash = { 'film_id' => film4.id, 'screening_time' => "18:00", 'price' => 6, 'number_of_tickets' =>10}
screening12_hash = { 'film_id' => film4.id, 'screening_time' => "21:00", 'price' => 9, 'number_of_tickets' =>10}

screening1 = Screening.new(screening1_hash)
screening1.save

screening2 = Screening.new(screening2_hash)
screening2.save

screening3 = Screening.new(screening3_hash)
screening3.save

screening4 = Screening.new(screening4_hash)
screening4.save

screening5 = Screening.new(screening5_hash)
screening5.save

screening6 = Screening.new(screening6_hash)
screening6.save

screening7 = Screening.new(screening7_hash)
screening7.save

screening8 = Screening.new(screening8_hash)
screening8.save

screening9 = Screening.new(screening9_hash)
screening9.save

screening10 = Screening.new(screening10_hash)
screening10.save

screening11 = Screening.new(screening11_hash)
screening11.save

screening12 = Screening.new(screening12_hash)
screening12.save

ticket1_hash = { 'customer_id'=> customer1.id, 'screening_id' => screening1.id}
ticket2_hash = { 'customer_id'=> customer1.id, 'screening_id' => screening4.id}
ticket3_hash = { 'customer_id'=> customer2.id, 'screening_id' => screening2.id}
ticket4_hash = { 'customer_id'=> customer2.id, 'screening_id' => screening8.id}
ticket5_hash = { 'customer_id'=> customer3.id, 'screening_id' => screening2.id}
ticket6_hash = { 'customer_id'=> customer3.id, 'screening_id' => screening4.id}
ticket7_hash = { 'customer_id'=> customer4.id, 'screening_id' => screening6.id}
ticket8_hash = { 'customer_id'=> customer4.id, 'screening_id' => screening4.id}
ticket9_hash = { 'customer_id'=> customer1.id, 'screening_id' => screening10.id}
ticket10_hash = { 'customer_id'=> customer2.id, 'screening_id' => screening11.id}
ticket11_hash = { 'customer_id'=> customer3.id, 'screening_id' => screening12.id}
ticket12_hash = { 'customer_id'=> customer4.id, 'screening_id' => screening2.id}

ticket1 = Ticket.new(ticket1_hash)
ticket1.save

ticket2 = Ticket.new(ticket2_hash)
ticket2.save

ticket3 = Ticket.new(ticket3_hash)
ticket3.save

ticket4 = Ticket.new(ticket4_hash)
ticket4.save

ticket5 = Ticket.new(ticket5_hash)
ticket5.save

ticket6 = Ticket.new(ticket6_hash)
ticket6.save

ticket7 = Ticket.new(ticket7_hash)
ticket7.save

ticket8 = Ticket.new(ticket8_hash)
ticket8.save

ticket9 = Ticket.new(ticket9_hash)
ticket9.save

ticket10 = Ticket.new(ticket10_hash)
ticket10.save

ticket11 = Ticket.new(ticket11_hash)
ticket11.save

ticket12 = Ticket.new(ticket12_hash)
ticket12.save

#Customer 1 buys a ticket for screening 7
#Checking the customers and screenings tables confirms customer1s funds decreases and the number_of_tickets availale also goes down
customer1.buy_ticket(screening8)

#Printing alternative methods of counting films/customers - both are returning the same values
p customer1.tickets_count_ruby
p customer1.tickets_count_sql
p film1.customers_count_ruby
p film1.customers_count_sql


binding.pry
nil
