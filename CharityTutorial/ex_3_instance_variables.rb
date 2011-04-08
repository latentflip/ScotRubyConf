class MyClass
  @variable = 99
end


#write a method to access the instance method @variable
#if you subclass it does it still work
#setter method, called in parent and subclass

class MyClass
  def self.get_instance
    @variable
  end
  def self.set_instance(value)
    @variable = value
  end

  def get_instance
    self.class.get_instance
  end

  def set_instance(*args)
    self.class.set_instance(*args)
  end
end

class MySubClass < MyClass
end

MyClass.set_instance(100)
MySubClass.set_instance(101)

puts MyClass.get_instance
puts MyClass.new.get_instance

puts MySubClass.get_instance
puts MySubClass.new.get_instance

