# Real Time Rack - Konstantin Haase
- @konstantinhaase

## Polling Sucks
- polling sucks
- so is long polling (comet)

## Technique
- start streaming, and while streaming decide what to stream, not up front
- Streaming APIs, server-sent events, websockets

## Rack
- Protocol web spec

    # Basic webapp
    welcome_app = proc do |env|
      [200, #status
        {'Content-Type': 'text/html'},
        ['Hello']
      ]
    end

## Realtime
- By default no streaming
- Can simulate it by returning something that responds to each

    def my_body.each
      20.times do
        yield "<p>%s</p>" % Time.now
        sleep 1
      end
    end

## Evented Streaming with async.callback
- Not in Rack spec
- But Thin, Goliath, etc expose async callbacks
    
    get '/' do
      EM.add_timer(10) do
        env['async.callback'].call [
          #rack response
        ]
      end
      #to prevent the webserver returning straight away, but to leave it open
      #skips the middleware
      throw :async 

      #or

      #will go through middleware, but each won't do anything
      #status of -1 says I will do it later, but gives a warning in dev mode (invalid status)
      [-1, {}, []]
    end

- require 'sinatra/async'
- This isn't streaming, it's postponing
- EM:Deferrable
  - 3 status
    - hasn't succeeded yet
    - succeeded
    - failed
  - can register callbacks to each

## Server Sent Events
- On way websockets (stream from server to client)
- No protocol upgrade
- Resumable (built-in when connection was dropped)
- Client implementable in JS (in anything > IE6)
- Degrades gracefully to polling

## Websockets
- Two way EventSources
- Client needs patching (protocol upgrade)
- Server needs patching
- Proxy need patching
- Rack needs patching
- Security issues

## SPDY
- Replacement for HTTPS
- Multiple requests over the same SSL connection
- Supports pushing over SSL
- but no Ruby implementation

## Socket.io
- (slides)[github.com/rkh/presentations]




