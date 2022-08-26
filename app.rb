require './book'
require './person'
require './rental'
require './student'
require './teacher'

# ┬├─┼╚▌cτσα↑¶↨↓→╗mƒ¡╕¿♣◘◘○◙♂☻πΓß▄▌▐▀αßΓπ╤¥▄

class App
  def initialize()
    @people = []
    @books = []
    @rentals = []
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
    # 8.times do |i|
    #   print "Sending.#{'.' * (i % 3)}  \r"
    #   $stdout.flush
    #   sleep(0.5)
    # end
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
      @people.push(Student.new(age, nil, name, permission == 'Y'))
    else
      print 'Specialization: '
      specialization = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp.upcase
      @people.push(Teacher.new(name, specialization, age, permission == 'Y'))
    end
    sending_message
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
    print "Rental created successfully\n"
    sleep 1
    run
  end

  def list_rentals
    if @people.length.positive?
      list_people
      print 'ID of person: '
      id_selected = gets.chomp.to_i
      @people.each do |person|
        if person.id == id_selected
          print "Rentals:\n\n"
          person.rentals.each_with_index do |item, idx|
            print " #{idx + 1}) Date: #{item.date}, Book: #{item.book.title} writed by #{item.book.author}\n\n"
          end
        else
          print "This ID hasn't rentals asigned for now\n\n"
        end
      end
    else
      print "There is no persons created\n\n"
    end
    back_main_menu
  end

  def end_app
    print "© Thanks for using School Library App ©\n"
  end
end
