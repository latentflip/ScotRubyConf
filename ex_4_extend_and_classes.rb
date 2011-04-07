#Define a method my_accessor that calls attr_accessor
#Alter it to record the attributes passed to it and a new class method to return that list
#Implement extend using include


#class MyClass
#  def self.my_accessor(field_name)
#    @my_attributes = []
#    @my_attributes << field_name
#    attr_accessor(field_name)
#  end
#  def self.my_attributes
#    @my_attributes
#  end
#
#  my_accessor :field1
#  my_accessor :field2
#end
#
#m = MyClass.new
#m.field1 = 99
#puts m.field1
#puts m.class.my_attributes

module MyStuff
  CONST = []
end


module AttrRecorder
  ALL_ATTRIBUTES = []

  def log_attribute(field_name)
    @my_attributes ||= []
    AttrRecorder::ALL_ATTRIBUTES << field_name
    @my_attributes << field_name
  end
  
  def all_attributes
    AttrRecorder::ALL_ATTRIBUTES
  end

  def my_accessor(field_name)
    log_attribute(field_name)
    attr_accessor(field_name)
  end

  def my_attributes
    @my_attributes
  end
end

#class Object
#  #Adds to every object
#  def self.exstend(mod)
#    #self.class.send(:include, mod)
#  end
#end



class MyClass
  extend(AttrRecorder)
  my_accessor :field1
  my_accessor :field2
end

class MyOtherClass
  exstend(AttrRecorder)

  my_accessor :field3
  my_accessor :field4
end

m = MyClass.new
m.field1 = 98
puts m.field1
p m.class.my_attributes

m = MyOtherClass.new
m.field3 = 99
puts m.field3
p m.class.my_attributes


p AttrRecorder::ALL_ATTRIBUTES

