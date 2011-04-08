# Matt Yoho - Rong

## Drawing

## Gosu: 2d drawing & game library
- 3d accelerated 2d text/graphics
- sound
- keyboard input

## Event loop
- http://code.google.com/p/gosu/wiki/windowmainloop

## Discrete vs. delta time
- Two kinds of timing
  - Discrete: assume an FPS and update physics 
  - Delta time: check the elapsed time, to update the physics equations
- Could be either for Pong, but if needs to sync with a server, delta time is better

## Point based physics
- Physics is based around a single point in space 
  - calculate physics based on that single point
- Actual character has a height and width
- But also has a different hit-box, to define where the character _overlaps_ another item

## Hit boxes
- 2d hit box may be overly simplistic for some applications, if the character is significantly incongruous from the rectangular box
- For more complex hit boxes, look at Chipmunk 
  - 2d collision detection
  - circle, polygon
  - multiple hit boxes
  - spatial hashing algorithm
    - high-level pass that can rule out comparisons between objects that are definitely not going to collide (opposite sides of the screen)
  - implemented in C (fast)

## You are writing a game, not a simulation
- Don't worry about underlying physics, make a game

## Client-Server

    #Server
    acceptor = Socket.new(...)
    address = Socket.pack_sockaddr_in(7664 #(port)
                                      Socket::INADDR_LOOPBACK)

    acceptor.bind(address)
    acceptor.listen(3)
    
    until connections.count == 2
      socket, addr = acceptor.accept
      connections << socket
    end

    #Client
    #similar, but address is remote address

## Ring Buffer
- Storing the packets
- Linked list
- Ring buffer throws away the data, automatically expires stale data

## Game runs on the server
- To prevent client-side hacks

## TCP vs UDP
- TCP
  - connection baed
  - guaranteed reliable & ordered
  - packets data for you
  - read and write like its a file
- UDP
  - firehose
  - no concept of a connection
  - no reliability/ordering (duplicates!)
  - manual packet breakup
  - must recreate as much TCP as your app needs
    - connections/ordering

- Do I care more about fast data, or perfect data

## Latency vs Rewind
- Latency between user action -> server calculations -> server event loop update -> server broadcast -> client update
- Rewind: server and client run concurrent simulations
  - But server is the canonical simulation, and is receiving data from multiple players
  - So if something different happens in server simulation to client simulation, need to rewind and replay client
  - Interesting valve papers on this
  - Results in _snap_
  - Easier to do all this with delta-timing algorithms

## Custom protocol
- Transmitting action
  - Tracking position
  - Started playing
  - Win conditions 
- Text or binary
  - binary packed is more common
  - text based is simple, nice for debug
  - Ragel
    - grammar for parseable/parsing text (used in Mongrel/Hpricot/etc)
  - [Typed Netstrings](codepad.org/0QQFDG9I)
    - simpler text format, combination of a compacted string, but simpler format

## Slides Are Online

## Matt Yoho


  
