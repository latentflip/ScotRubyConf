def counter(start=0, increment=1)
  lambda do
    val = start
    val += increment
    val
  end
end

result = counter(10,2)

puts result.call #=>10
puts result.call #=>12
puts result.call #=>14

result = counter(2,3)
puts result.call #=>2
puts result.call #=>5
