def block_in_sandbox(param)
  lvar = "local variable"
  lambda do
    puts "param = #{param}"
    puts "lvar = #{lvar}"
  end
  #=> Returns the lambda
end

block = block_in_sandbox(99)
block.call
