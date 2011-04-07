# The Ruby Object Model

- self is the current object
  - default receiver of method calls
  - place where instance variables are kept

- self always had a value

# What changes self?
- method call
- class/method definition

# On a method call

- Switch self to receiver
- Look up method in self's class (and up the chain)
- Invoke method

# An example

    class Dave
      def return_self
        return self
      end
    end

    d = Dave.new

    puts self           #=> main
    puts d.return_self  #=> #<Dave:0x...>
    puts self           #=> main

# Methods on an object

    animal = "cat"
    def animal.speak
      puts 'Miaow'
    end
    animal.speak    #=> Miaow
    animal = 'dog'
    animal.speak    #=> MethodMissing


# Singleton Class

- aka Metaclass/EigenClass/Uniclass
- regular but hidden
- participates in inheritance
- nothing to do with singleton pattern?


# _self_ and Class Definition

    class Test
      puts "In the definition of class Test"
      puts "self = #{self}"
      puts "Class of self = #{self.class}"
    end

    puts "Top level, self = #{self}"


# Classes and Instances

    class MyClass
      @iv = 123
      puts = "In class definition, @iv = #{@iv}"
      def self.class_method
        puts "In class method, @iv = #{@iv}"
      end

      def instance_method
        puts "In instance method, @iv = #{@iv}"
      end
    end
    
    MyClass.class_method
    MyClass.new.instance_method


# There is no such thing as a class method

    def Array.speak
      "meow"
    end
    puts Array.speak

    # or

    class Array
      def self.speak
        "meow"
      end
    end
    puts Array.speak

# Chain

    String #=> String
    String.class #=> Class
    String.class.superclass #=> Module

- Class is a subclass of Module
  - Modules: namespaces and methods
  - Class: namespaces, methods, and instantiation
- So a Module is _more_ general than a class

    Class.instance_methods - Module.instance_methods
    #=> ['superclass', 'allocate', 'new']
    
    Animal.one_class_method #=> is a method on the singleton class of Animal class

# Singletons

- Instance variables looked up in the current self
- Methods are looked up in the current self's class

    def fred      #=> defines a method in the current class
    def obj.fred  #=> always defines a method in the singleton class

# Accessing the singleton/upna/eigen class

- Opens the singleton class of an object
- Syntax

    #class << obj

    class MyClass
      @variable = 99
      
      class << self
        def get_variable
          @variable
        end
      end
    end

    # equivalent to

    class MyClass
      @variable = 99

      def self.get_variable
        @variable
      end
    end

- which syntax is better is up to you


# Accessing eigenclass

    class Object
      def eigen_class
        class << self
          self
        end
      end
    end

    ec = 'asdf'.eigen_class
    p ec 
    #=> #<Class:#<String:0x101848300>>

- but can't subclass an eigenclass


# Setters/Getters on a Class

- attr\_\* on a singleton class

# Inheriting from expressions

    require 'date'

    def determine_class
      if Date.today.wednesday? 
        []
      else
        {}
      end
    end

    class MyName < determine_class
    end


    class Person < Struct.new(:name, :age)
    end

# Class Method Inheritance


    class Parent
      def self.hello
        puts "hi from #{self}"
      end
      hello #=> hi from Parent
    end
    class Child < Parent
      hello #=> hi from Child
    end

# Include

- Haven't really mixed in the methods
- Inserts the module right above the class in the hierarchy
- It's a pointer to the logger module's methods table
- Go to the eigenclass, then the Class, then the module(s)

    module Logger
      def log(msg)
        puts msg
      end
    end

    class Album
      include Logger
    end

    class Song
      include Logger
    end

- If lost, Class.ancestors lists the ancestor & lookup hierarchy


# Extend

- Adds methods to the receiver's singleton class

    module Vocal
      def speak
        puts "#{self} says hello"
      end
    end

    animal = 'cat'
    animal.extend Vocal
    animal.speak


