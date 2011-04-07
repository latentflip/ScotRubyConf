class Foo
  puts "self = #{self}"
end

class Bar
  self.puts "self = #{self}"
  def puts
    "HarHar"
  end
end
