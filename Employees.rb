class Employee

  attr_reader :salary

  def initialize(name, title = "monkey", salary = 60_000)
    @name = name
    @title = title
    @salary = salary
  end

  def set_manager(manager)
    @boss.remove_employee(self) if @boss
    manager.add_employee(self)
    @boss = manager
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end


class Manager < Employee

  attr_reader :employees

  def initialize(name)
    @employees = []
    super(name)
  end

  def add_employee(employee)
    @employees << employee
  end

  def remove_employee(employee)
    @employees.delete(employee)
  end

  def bonus(multiplier)
    total_salary_of_underlings = 0
    underlings = @employees
    until underlings.empty?
      underling = underlings.shift
      underlings += underling.employees if underling.class == Manager
      total_salary_of_underlings += underling.salary
    end
    total_salary_of_underlings * multiplier
  end


end
