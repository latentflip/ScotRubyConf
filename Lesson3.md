# Metaprogamming

# Eval

- eval('puts "hello"')
- string can be dynamic

    def create_greeting(method_name, greeting)
      code = %{
        def #{method_name}(person)
          puts "#{greeting.capitalize} #{person}"
        end
      }
      eval code
    end
    
    create_greeting('texan', 'howdy')
    texan('Dave')

- pretty fast, but dangerous
- can be safe in terms of memory consumption
- private methods can only be called on the _implicit_ receiver

# Example

    create_multiplier(2)
    puts times_2(3) #=> 6
    puts times_2(4) #=> 8

# Binding

    def my_method(p1, p2)
      local_var = 99
      binding
    end
    
    methods_binding = my_method('cat', 'dog')

    puts eval('p1', methods_binding) #=> p1 is set from the my_method call and stored in the binding

    puts methods_binding.eval('p2')


# Binding & Blocks
    def my_method(p1,p2)
      count= 0
      lambda { count += 1; [count, p1, p2] }
    end

    resulting_proc = my_method('cat', 'dog')

    p resulting_proc.call  #[1, 'cat', 'dog']
    p resulting_proc.call  #[2, 'cat', 'dog']
    p resulting_proc.call  #[3, 'cat', 'dog']

    p eval('count', resulting_proc.binding)

- we can even access a proc/block's binding if our method is passed a block


# Example

    def create_multiplier(factor)
      lambda do |param|
        param * factor
      end
    end

    times_2 = create_multiplier(2)
    times_2.call(3) #=> 6
    times_2.call(4) #=> 8

- _factor_ is bound to the proc


# instance\_eval

    class MyClass
      def initialize(p1)
        @p1 = p1
        @other = 'wibble'
      end
    end

    m = MyClass.new

    p self #=> main
    m.instance_eval { p self } #=> #<MyClass...>
    m.instance_eval { @other = 'NO'} #=> #<MyClass...>


# class\_eval

- instance\_eval defines it as a class method
- class\_eval defines it as an instance method (open the class and edit)


# define\_method

- defines instance\_method on the receiving class
- can only be called on classes
- block params become method params
- block is a closure at point of definition


    class MyClass
      define_method(:fred) do |param|
        puts "fred(#{param})"
      end
      def self.my_create_method(name, param)
        define_method(name) do
          puts name.to_s + ": " + param
        end
      end
    end

    MyClass.my_create_method('Betty', 'Charge!')


    class PeopleController < ApplicationController
      def search
        @results = Person.search(params[:term])
        render '/search/results'
      end
    end

    class ApplicationController
      def self.search_for(model)
        define_method(:search) do
          #Model is bound from the model param
          @results = model.search(params[:term])
          render "search/results"
        end
      end
    end

    class PeopleController < ApplicationController
      search_for Person
    end

    
    class PeopleController < ApplicationController
      include RestStuff
    end

# Example

    class MyClass
      def self.create_multiplier(factor)
        define_method("times_#{factor}") do |param|
          param * factor
        end
      end
    end

    MyClass.create_multiplier(2)
    m = MyClass.new
    puts m.times_2(3)

# main

    class Object
      Object.new.instance_eval do 
        def self.to_s
          "main"
        end

        #Your code goes here
      end
    end


#Class.new

    p String
    x = Class.new
    Chad = x

    Alien = Class.new do
      define_method(:methname) do |param|
        puts "Got #{param}"
      end
    end

# Hooks

- Around
  - method\_missing, method\_added etc

# Method Missing

- "Catchall"
- Inherited
- If a method\_missing has a known repeatable result, have method\_missing create a block, which is used to define a method on the class (faster next time)

# const\_missing

- Look at active\_support's dependency loading
