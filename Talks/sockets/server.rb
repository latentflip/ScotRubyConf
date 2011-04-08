require 'socket'
include Socket::Constants
acceptor = Socket.new( AF_INET, SOCK_STREAM, 0)
address = Socket.pack_sockaddr_in( 7664, '127.0.0.1')
acceptor.bind(address)
acceptor.listen(5)
begin
  connections = []
  until connections.count == 1
    client, addr = acceptor.accept
    puts client.readline.chomp
    connections << client
  end

  while true
    #client.puts gets
    puts client.readline.chomp
    client.puts 'asdf'
  end

rescue
  acceptor.close
  puts 'Done!'
end
