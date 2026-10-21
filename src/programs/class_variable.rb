class Employee
  @@counter = 0

  def initialize
    @@counter += 1
  end

  def self.count
    @@counter
  end
end

class Staff < Employee
end


e1 = Employee.new
p "Employee count #{Employee.count} Staff count #{Staff.count}"
s1 = Staff.new
p "Employee count #{Employee.count} Staff count #{Staff.count}"

e2 = Employee.new

p "Employee count #{Employee.count} Staff count #{Staff.count}"