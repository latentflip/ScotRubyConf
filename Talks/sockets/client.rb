require 'socket'
include Socket::Constants
socket = Socket.new(AF_INET, SOCK_STREAM, 0)
sockaddr = Socket.sockaddr_in(7664, '127.0.0.1')
socket.connect(sockaddr)
#begin
  while true
    #puts socket.readline.chomp
    #puts socket.readline.chomp if socket.readline
    socket.puts gets
    puts socket.readline.chomp
  end
#rescue
  socket.close
  puts 'Done!'
#end
