class Book
  attr_reader :id
  attr_accessor :title, :author, :rentals

  def initialize(title, author, id = nil)
    @title = title
    @author = author
    @id = id || Random.rand(1...100_000)
    @rentals = []
  end

  def add_rental(rental)
    @rentals.push(rental)
    rental.book = self
  end
end
