# Block Invocation
    one two {} #binds to two

    one two do #binds to one
    end


# yield
- You can always add a block on a method invocation, but it won't always do anything
- "Yield" control of execution to the block that was passed
- 'return' does not return from a block (LocalJumpError)
- Calling yield without a block being passed also raises a LocalJumpError, so test first with block_given?
- Using block_given? we can treat method differently 


    #Ugly and old
    file = File.open('/etc/passwd')
    file.read
    file.close

    #Finish what you started
    File.open('/etc/passwd') do |f|
      puts f.read
    end

# break
- Kind of like returning from a block, but wierder than that
- breaks out of both the block and the method

    def show_break
      puts 'before yield'
      yield
      puts 'after yield' # never get here
    end

    puts 'before call'
    result = show_break do
      puts 'before break'
      break 123
      puts 'after break' #never get here
    end
    puts 'after call, result = #{result}'

    # => before call
    # => before yield
    # => before break
    # => after call, result = 123

# next
- More like return for a block
- Makes a lot of sense in a loop

    i = 0
    loop do
     i += 1
     next if i.even?
     puts i
   end
   # prints only odd numbers

- Does the same in a regular block invocation, even if it's less obvious

# Returning from a block
- You _can_ if return makes sense, but probably shouldn't
- This will exit both the _loop_ and _a_method_

    def a_method
      loop do
        return if some_condition
      end
    end

# redo
- Kind of like _goto_ the start of the block but maintaining local scope

    result = show_redo do
      count += 1
      redo if count < 3
    end

- Not very useful normally, unless trying to deal with random (timing) exceptions

# How would you do?
    def loop_while(cond)
      # how do we do this?
    end

    i = 0
    loop_while i < 3 do
      puts i
      i += 1
    end

- i < 3 is evaluated on invocation, so that you can never look at 
- only way to do this is in ruby 1.8

    def loop_while(cond)
      if cond
        yield
        retry
      end
    end

- which pops all the way back out to before loop_while
- perhaps possible with continuations in ruby 1.9?

# Blocks into objects

- A block is a language level thing (c-level) that we have little access to except yield
- Might be useful to capture it as an object to use it later

    def show_block_param(&x)
      puts x.inspect
      x.call
      yield
    end

    show_block_param { puts "in block" }

    #=> <Proc:0x...>

- Proc's don't care if their arguments are missing, or too many
    
    def yield_it(&x)
      x.call
      x.call(123, 234, 345)
    end

    yield_it {|thing| puts "Got a #{thing}"}
    
    #=> Got a  #thing is nil
    #=> Got a 123 #extra args ignored

#Lamda, proc, Proc.new

- (Mostly) synonymous
- lambda is much the same as

    def my_lambda(&block)
      block
    end

- 1.8: _proc_ and _lambda_ are synonyms
- 1.9: _proc_ and _Proc.new_ are synonyms

# lambda != Proc.new

    Proc.new {|a,b|}.call(1,2,3) #OK
    Proc.new {|a,b|}.call(1) #OK

    lambda {|a,b|}.call(1) #=> wrong number of arguments

- use lambda all the time, unless you know why Proc.new
- never use Proc.new


# 1.8 block args act like assignment, not 1.9 :(

    class Person
      attr_accessor :age
    end

    chad = Person.new
    chad.age = 99 #=> converted to chad.age=(99) 'calls the age=() method'
    p chad

    3.times {|a| puts a}    #=> assigns to a local _a_
    3.times{|@a| puts @a}   #=> assigns to @a, which hangs around

    #in 1.8 can do

    str = 'wibble'
    def str.x=(pos)
      self[pos,1] = "X"
    end

    3.times {|str.x| puts str}
    
    #=> Does a syntactical trick like str.x => str.x=()

    #=> Xibble
    #=> XXbble
    #=> XXXble

# Bindings/Closures

- Encapsulate the context at a point of execution
- The context is:
  - Accessiblity of local variables / method params
  - Value of self
  - Instance variables
  - Any associated block
  - the _return_ stack
- Does not simply record the then-current values of these things: keeps full context

    class A 
      attr_writer :ivar
      def initialize
        @ivar = 123
      end
      def get_a_binding_thing
        lvar = "lvar"
        binding
      end
    end

    a = A.new
    bind = a.get_binding { "block value" }
    eval "puts lvar", bind                  #=> lvar
    eval "puts @ivar", bind                 #=> 123

    a.ivar = "new value"
    eval "puts @ivar", bind                 #=> new value
    eval "puts yield", bind                 #=> block value
    eval "puts self", bind                  #=> <A:0x...>

- Would we ever do this?


# Closures

- Blocks carry with them the binding in which they are created

    def block_in_sandbox(param)
      lvar = "local variable"
      lambda do
        puts "param = #{param}"
        puts "lvar = #{lvar}"
      end
    end
    
    block = block_in_sandbox(99)
    block.call

    #=> 'param = 99'
    #=> 'lvar = local variable'


# DSLs
- Object Oriented API under-the-hood
- Build up an object graph with a block-based DSL
