require './person'

class Student < Person
  attr_accessor :parent_permission
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission = true, id = nil)
    super(age, name, id, parent_permission)
    @classroom = classroom
  end

  def belong_to(classroom)
    @classroom = classroom
    classroom.student.push(self) unless classroom.student.include?(self)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
