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
- 







