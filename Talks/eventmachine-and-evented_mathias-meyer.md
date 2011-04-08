- Eventmachine: evented non-blocking I/O for ruby

- Server workflow
  - one request at a time
  - lots of waiting

- I/O blocks the workflow (can't do anything while we wait for other stuff)

- Could try threading, but doesn't fix it
- No C10K even with threading (read this article)

# Why evented I/O 

- Lots of things are I/O bound, but little processing is actually involved

## Examples

- Proxies
- Soft Realtime Rpps
- Streaming/Firehose APIs
- Messaging (RabbitMQ)
- Pub/Sub System
- Simple APIs
- Networkd servers/clients

# Makes sense when throughput > processing

# What we really want

- Don't call us, we'll call you

# Eventmachine

- Source is c++ & nice
- Event loop
  - basically a while true loop
  - checks sockets on each loop/fires timers/fires logic
- Reactor pattern
  - reacts to new data

    response = get_some_data do |request|
      send_response #=> this is a callback
    end

- Runs callbacks on events
  - on connection
  - on receive data
  - on connection closed
  - timer fired
  - keyboard
  - file watchers

- single-threaded, but could be multi-threaded
  - code does not run procedurally
  - multiple I/O ops
  - one processing op at a time, make it fast since it will block the loop

# The loop

    EM.run do 
      ...
    end

- Threads are supported, but...
- I/O always on the Reactor Thread

# Echo server

    EM.start_server '127.0.0.1', 8081 do |conn|
      def conn.receive_data(data)
        send_data(data)
      end
    end

- no boilerplate networking code
- can put callbacks in a module

    EM.start_server '127.0.0.1', 8081, Echo #module Echo; end

    module EchoClient
      def post_init
        #when the connection is created
      end
    end

- wrap it in EM.run


# EM in real life

- em-http-request

# Lots of callbacks

# Wouldn't in be nice if it was more procedural - Fibers!

- are terrible
- not in ruby 1.8
- "Lightweight Concurrency"
- Continuations/Co-Routines/Fibers
  - Pause execution until you tell me I can go again

  - require 'fiber'
  - wrap stuff in a new fiber

# em-synchrony

- Deals with the fiber stuff for you
- Lets you write stuff procedurally, but user the evented I/O

# Other libraries on top of EM

- proxymachine
- em-proxy
  - redirect production traffic to staging & production server, but only respond from production server
  - lets you test production traffic on staging code
- goliath
  - evented web framework
  - rack api
  - fibers (1.9 onlt)
- tramp 
  - evented ORM

# Rails on eventmachine
- Rails 2.3/3.0 on 1.9 with Fibers

    Em.add_timer(1) do
      #run in one second
    end

    EM.add_periodic_timer(1) do
      #run every second
    end

- split stuff up over multiple loop iterations
- don't wish to block the loop

    EM.next_tick # schedule for the next loop

    i = 0
    block = proc do
      if i < 100
        i +=1 
        EM.next_tick &block
      end
    end
    EM.next_tick &block

# EM.defer

- Run stuff in a different ruby thread without blocking the main event loop

    EM.next_tick do
      EM.defer do
        puts "IN THREAD"
        EM.next_tick do
          puts "IN REACTOR THREAD"
        end
      end
    end

# Queuing

- Queue/defer log writes 

# EM.epoll / EM.kqueue

# Caveats

- Don't block the event loop push blocking stuff somewhere else
- Net::HTTP => EM::HttpRequest
- Should I run Rails on EM
  - Yes & no (processing kills the event loop)
  - If it's a fast response good, if slow to render, can't avoid that
  - Harder to debug
    - Don't have a stack anymore!
    - Harder to handle errors (can't just raise an exception)

# Eventmachine is not a scaling silver bullet

# Or just use Erlang

