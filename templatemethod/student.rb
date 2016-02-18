# Template Method Pattern
# Date: 27-Jan-2016
# Authors:
#          A01020319 Fernando Gómez Herrera
# File name: student.rb

class Student

  include Enumerable
  # Note: This class does not support the max, min, or sort methods.

  def initialize(id, name, grades)
    @id = id
    @name = name
    @grades = grades
  end

  def inspect
    "Student(#{@id}, #{@name.inspect})"
  end

  def grade_average
    @grades.inject(:+)/@grades.size
  end

  def each &block
    yield @id
    yield @name
    @grades.each(&block)
    yield grade_average
  end

end
