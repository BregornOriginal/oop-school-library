require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'

class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age, :rentals

  def initialize(age, name = 'Unknown', id = nil, parent_permission = true)
    super()
    @parent_permission = parent_permission
    @name = name
    @age = age
    @id = id || Random.rand(1...100_000)
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(book, date)
    Rental.new(book, self, date)
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
