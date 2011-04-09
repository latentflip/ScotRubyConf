#An awful webserver

class HTTPParser < Array
  attr_accessor :env
  def initialize
    super
    @env ||= {}
  end
  def parse
    self.each do |line|
      parts = line.split(':', 1)
      @env[parts[0]] = parts[1]
    end
    @env
  end
end

require 'socket'
include Socket::Constants
port = ARGV[0]
puts "Running on port #{port}"

acceptor = Socket.new( AF_INET, SOCK_STREAM, 0)
address = Socket.pack_sockaddr_in( port.to_i, '127.0.0.1')
acceptor.bind(address)
acceptor.listen(5)

connections = []
until connections.count == 1
  client, addr = acceptor.accept
  connections << client
end

i=0 
parser = HTTPParser.new
while line = client.readline.chomp
  if line.nil? || line == ''
    break
  end
  parser << line.chomp
end

p parser.parse

client.puts 'asdf'
acceptor.close
puts 'Done!'
