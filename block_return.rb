def a_method
  puts 'before a block'
  result = yield
  puts "I got '#{result}'"
  puts 'after a block'
end

def another_method
  puts 'before a_method'
  a_method do
    return
  end
  puts 'after a_method'
end

another_method
