fiber = Fiber.new do |first|
    second = Fiber.yield first + 2
    #second = first + 2
end

puts 'at the start'
puts fiber.resume 10
puts 'in the middle'
puts fiber.resume 14
puts 'at the end'
#puts fiber.resume 

