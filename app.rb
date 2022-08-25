require './book'
require './person'
require './rental'
require './student'
require './teacher'

class App
  def initialize()
    @people = []
  end

  def run
    puts 'Welcome to School Library App!'
    puts "\n"
    puts 'Please choose an option by enterin a number:'
    puts '1- List all books'
    puts '2- List all people'
    puts '3- Create a person'
    puts '4- Create a book'
    puts '5- Create a rental'
    puts '6- List all rentals for a given person id'
    puts '7- Exit'
    @user_choise = gets.chomp.to_i
    options
  end

  def list_all_books; end

  def list_all_people; end

  def list_all_rentals; end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2) [input the number]: '
    type_of_person = gets.chomp.to_i
    if type_of_person == 1
      print 'Name: '
      name = gets.chomp
      print 'Age: '
      age = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Student.new(age, nil, name, permission == 'Y'))
      p @people
    else
      print 'Name: '
      name = gets.chomp
      print 'Age: '
      age = gets.chomp
      print 'Specialization: '
      specialization = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Teacher.new(age, specialization, name, permission == 'Y'))
      p @people
    end
  end

  def options
    case @user_choise
    when 1
      'You ran out of gas.'
    when 2
      'The tank is almost empty. Quickly, find a gas station!'
    when 3
      create_person
    when 4
      'The tank is almost full.'
    when 5
      '5'
    when 6
      '6'
    when 7
      '7'
    else
      "Error: capacity has an invalid value (#{capacity})"
    end
  end
end
