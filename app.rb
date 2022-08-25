require './book'
require './person'
require './rental'
require './student'
require './teacher'

class App
  def initialize()
    @people = []
    @books = []
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
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    if type_of_person == 1
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Student.new(age, nil, name, permission == 'Y'))
    else
      print 'Specialization: '
      specialization = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Teacher.new(name, specialization, age, permission == 'Y'))
    end
    print "Person created successfully\nPress any key to back main menu"
    wait = gets.chomp
    run
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    print 'Press any key to back main menu'
    wait = gets.chomp
    run
  end

  def list_people
    @people.each_with_index do |person, idx|
      line = "#{idx}) [#{person.class}] Name: #{person.name}, Age: #{person.age} ID: #{person.id}\n"
      print line
    end
    print "Press any key to back main menu"
    wait = gets.chomp
    run
  end

  def list_books
    @books.each_with_index { |book, idx| print "#{idx + 1}) Title: #{book.title}, Author: #{book.author}\n" }
    print "Press any key to back main menu"
    wait = gets.chomp
    run  
  end

  def options
    case @user_choise
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      rent_a_book
    when 6
      '6'
    when 7
      '7'
    end
  end
end
