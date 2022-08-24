require './capitalize_decorator'
require './classroom'
require './decorator'
require './nameable'
require './person'
require './student'
require './teacher'
require './trimmer_decorator'

first_classroom = Classroom.new(10)

julio1 = Person.new(18, 'Julio')
gonzalo1 = Person.new(16, 'Gonzalo')

print "Nueva persona\n"

p julio1
p gonzalo1

print "Nuevo estudiante\n"

gonzalo = Student.new(16, nil, 'Gonzalo')
julio = Student.new(18, first_classroom, 'Julio')

p julio
p gonzalo

print "Agregar persona a classroom\n"

p julio.belong_to(first_classroom)
p gonzalo.belong_to(first_classroom)

print "Classroom 10\n"

p first_classroom

print "CONTADOR\n"

p first_classroom.student.first.name

p student
