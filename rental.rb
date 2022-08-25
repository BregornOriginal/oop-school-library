class Rental
  attr_reader :book, :person
  attr_accessor :date

  def initialize(date, book, person)
    @date = date

    @book = book
    book.rentals << self

    @person = person
    person.rentals << self

    @books = []
  end

  def add_book(book)
    @books.push(book)
    book.rentals = self
  end
end
