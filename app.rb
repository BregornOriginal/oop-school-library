require './book'
require './person'
require './rental'
require './student'
require './teacher'
require 'json'

# ┬├─┼╚▌cτσα↑¶↨↓→╗mƒ¡╕¿♣◘◘○◙♂☻πΓß▄▌▐▀αßΓπ╤¥▄

class App
  attr_accessor :people, :books, :rentals
  DATA_DIRECTORY = './library_data/'.freeze

  def initialize()
    @people = []
    @books = []
    @rentals = []
    @clasroom = 'default class'
    read_people_from_file
    read_books_from_file
    read_rentals_from_file
  end

  def run
    clear_console
    puts "\n"
    puts '◘◘◘◘◘◘◘◘◘◘ Welcome to School Library App! ◘◘◘◘◘◘◘◘◘◘'
    puts "\n"
    puts 'Please choose an option by enterin a number:'
    puts "\n"
    puts '1 → List all books'
    puts '2 → List all people'
    puts '3 → Create a person'
    puts '4 → Create a book'
    puts '5 → Create a rental'
    puts '6 → List all rentals for a given person id'
    puts '7 → Exit'
    puts "\n"
    @user_choise = gets.chomp.to_i
    options
  end

  def clear_console
    system('clear')
  end

  def options
    case @user_choise
    when 1 then list_books
    when 2 then list_people
    when 3 then create_person
    when 4 then create_book
    when 5 then rent_a_book
    when 6 then list_rentals
    when 7 then end_app
    else print "Please select a valid option, it's accept numbers 1 to 7\n"
         sleep 3
         run
    end
  end

  def back_main_menu
    print "Press any key to go back to main menu\n"
    wait = gets.chomp
    run
  end

  def list_people
    @people.each_with_index do |person, idx|
      line = "#{idx + 1}) [#{person.class}] Name: #{person.name}, Age: #{person.age} ID: #{person.id}\n"
      print line
    end
    back_main_menu
  end

  def list_books
    @books.each_with_index { |book, idx| print "#{idx + 1}) Title: #{book.title}, Author: #{book.author}\n" }
    back_main_menu
  end

  def sending_message
    8.times do |i|
      print "Sending.#{'.' * (i % 3)}  \r"
      $stdout.flush
      sleep(0.5)
    end
  end

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
      @people.push(Student.new(age, @classroom, name, permission == 'Y', id = nil))
    else
      print 'Specialization: '
      specialization = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Teacher.new(age, specialization, name, permission == 'Y', id = nil))
    end
    sending_message
    write_people_data
    print "Person created successfully\n"
    sleep 1
    run
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    print "\n"
    sending_message
    write_books_data
    print "Book created successfully\n"
    sleep 1
    run
  end

  def rent_a_book
    print "Select a book from the following list by number\n"
    @books.each_with_index { |book, idx| print "#{idx + 1}) Title: #{book.title}, Author: #{book.author}\n" }
    book_selected = gets.chomp.to_i
    print "Select a person from the following list by number\n"
    @people.each_with_index do |person, idx|
      line = "#{idx + 1}) [#{person.class}] Name: #{person.name}, Age: #{person.age}\n"
      print line
    end
    person_selected = gets.chomp.to_i
    print "Please enter the date[yyyy-mm-dd]\n"
    date = gets.chomp
    @rentals.push(Rental.new(date, @books[book_selected - 1], @people[person_selected - 1]))
    sending_message
    write_rentals_data
    print "Rental created successfully\n"
    sleep 1
    run
  end

  def list_rentals
    if @people.length.positive?
      print 'ID of person: '
      id_selected = gets.chomp.to_i
      @people.each do |person|
        if person.id == id_selected
          print "Rentals:\n\n"
          person.rentals.each_with_index do |item, idx|
            print " #{idx + 1}) Date: #{item.date}, Book: #{item.book.title} written by #{item.book.author}\n\n"
          end
        end
      end
    else
      print "There is no persons created\n\n"
    end
    back_main_menu
  end

  def read_books_from_file
    if File.exist?("#{DATA_DIRECTORY}books.json")
      books_file = File.open("#{DATA_DIRECTORY}books.json")
      data = JSON.parse(books_file.read)
      data.each do |book|
        @books << Book.new(book['title'], book['author'], book['id'])
      end
      books_file.close
    else
      @books = []
      write_books_data
    end
  end

  def write_books_data
    data = if @books.length.positive?
             @books.map do |book|
               { title: book.title, author: book.author, id: book.id }
             end
           else
             []
           end
    books_file = File.open("#{DATA_DIRECTORY}books.json", 'w')
    books_file.write(JSON.pretty_generate(data))
    books_file.close
  end

  def read_people_from_file
    if File.exist?("#{DATA_DIRECTORY}people.json")
      people_file = File.open("#{DATA_DIRECTORY}people.json")
      data = JSON.parse(people_file.read)
      data.each do |person|
        case person['class']
        when 'Student'
          @people << Student.new(person['age'], person['clasroom'], person['name'], person['parent_permission'],
             person['id'])
        when 'Teacher'
          @people << Teacher.new(person['age'], person['specialization'], person['name'], person['id'])
        end
      end
      people_file.close
    else
      @people = []
      write_people_data
    end
  end

  def write_people_data
    data = if @people.length.positive?
             @people.map do |person|
               if person.instance_of?(Student)
                 { class: person.class, age: person.age, name: person.name, classroom: @clasroom,
                   parent_permission: person.parent_permission, id: person.id }
               elsif person.instance_of?(Teacher)
                 { class: person.class, age: person.age, name: person.name, specialization: person.specialization,
                   id: person.id }
               end
             end
           else
             []
           end
    people_file = File.open("#{DATA_DIRECTORY}people.json", 'w')
    people_file.write(JSON.pretty_generate(data))
    people_file.close
  end

  def read_rentals_from_file
    if File.exist?("#{DATA_DIRECTORY}rentals.json")
      rentals_file = File.open("#{DATA_DIRECTORY}rentals.json")
      data = JSON.parse(rentals_file.read)
      data.each do |rental|
        filtered_person = @people.find { |person| rental['person_id'] == person.id }
        filtered_book = @books.find { |book| rental['book_id'] == book.id }
        @rentals << Rental.new(rental['date'], filtered_book, filtered_person)
      end
      rentals_file.close
    else
      @rentals = []
      write_rentals_data
    end
  end

  def write_rentals_data
    data = if @rentals.length.positive?
             @rentals.map do |rental|
               { date: rental.date, person_id: rental.person.id, book_id: rental.book.id }
             end
           else
             []
           end
    rentals_file = File.open("#{DATA_DIRECTORY}rentals.json", 'w')
    rentals_file.write(JSON.pretty_generate(data))
    rentals_file.close
  end

  def end_app
    print "© Thanks for using School Library App ©\n"
  end
end
