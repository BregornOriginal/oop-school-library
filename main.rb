require './capitalize_decorator'
require './classroom'
require './decorator'
require './nameable'
require './person'
require './student'
require './teacher'
require './trimmer_decorator'
require './book'
require './rental'
require 'date'

# first_classroom = Classroom.new(10)

# julio1 = Person.new(18, 'Julio')
# gonzalo1 = Person.new(16, 'Gonzalo')

# print "Nueva persona\n"

# p julio1
# p gonzalo1

# print "Nuevo estudiante\n"

# gonzalo = Student.new(16, nil, 'Gonzalo')
# julio = Student.new(18, first_classroom, 'Julio')

# p julio
# p gonzalo

# print "Agregar persona a classroom\n"

# p julio.belong_to(first_classroom)
# p gonzalo.belong_to(first_classroom)

# print "Classroom 10\n"

# p first_classroom

# print "CONTADOR\n"

# p first_classroom.student.first.name

# p student

julio_person = Person.new(18, 'Julio')
julio_book = Book.new('Best', 'Book')
julio_book2 = Book.new('Second', 'Book')

print "Nueva persona\n"
p julio_person

print "Nuevo libro\n"
p julio_book

julio_renta = Rental.new('2022-08-24', julio_book, julio_person)
julio_renta = Rental.new('1922-08-24', julio_book2, julio_person)

add_book_to_julio = julio_renta.add_book(julio_renta)

print "Nueva renta\n"

p julio_renta.person.rentals.first.book

print "Agregar libro\n"

add_book_to_julio