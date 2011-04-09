# A Path To Ruby Web Mastery

## Frameworks
- Wonderful abstraction
- The old schoolers get the benefit of this abstraction, as they have seen the pain
- New schoolers haven't seen the pain

## Rails
- Huge flash-bang, from _rails s_ to a fll stack webserver with no work
- But do we really know what we are doing under the hood?
- Rails is great for CRUD, but eventually we will hit an application where Rails is painful, and if we don't understand the abstractions it's hard to know where to go

## Example
- Problem here:
  - 30.days.ago & Time.now are evaluated at class load time
  - So if the server is up for 100 days, 30.days.ago is 130.days.ago
  - And we will never see this in development, since classes are reloaded on _every_ request


    class User < ActiveRecord::Base
      scope :recently_signed_up,
            :conditions => {:created_at => (30.days.ago..Time.now)}
    end

## Rails is not Ruby for beginners
- Hides lots about HTTP requests
- Blurs the lines between _rails_ and _ruby_
- Lots going on between request and response
  - Web Server
  - App Router
  - Bus Logic
  - Data Abstraction
  - Database Access
  - Html Templating
  - Testing Stack
- Noun/REST routing model confuses the situation for newbies

## Mastering the Web With Ruby
### Shu Ha Ri (from martial arts)
  - Similar to the model in the Pragmatic Thinking & Learning Book
- Skills acquisition model
- Shu
  - Ruthless practice of the fundamentals
- Ha
  - Detachment from beginner things
  - Look at the theory in practice
- Ri
  - Transcend learnings
  - Tacit knowledge
  - Lose focus on the rules

### In Ruby & The Web
- Shu (obey)
  - Do everything as the master says, dogmatic
  - Like scales in music

    1 #!/usr/bin/env ruby
    2 
    3 puts 'word.'

  - How do we web enable this?
  - This is a valid web application

    1 #!/usr/bin/env ruby
    2
    3 puts 'Content-Type: text/html\r\n'
    4 puts 'word.'

  - Not very ruby
  - Not OO


    class MyApplication
      def setup_headers
      end
      def display_word
        
      end
    end
    app = MyApplication.new
    app.setup_headers
    app.display_word

  - And More

    class MyApplication
      def self.run!
        app = self.new
        app.run
      end
      def run
        setup_headers
        display_word
      end
    end

  - Route using a Routes hash, and redirect to methods based on the ENV['REQUEST_URI']

## Shu to Ha
- From not knowing what you are doing, but learning from muscle memory
- So that it becomes part of who we are

## Ha
- Rack
  - Abstract HTTP, but focus on your pieces
  
    class MyApplication
      def call(env)
        [
          200,
          {
            'Content-Type' => 'text/html'
          },
          'word'
        ]
      end
    end

    use Rack::ContentLength #Concept of middleware
    run MyApplication.new

- Sinatra
  - Think more clearly about the relationship between URL & business logic
  - Frees us up from thinking about the actual content we are returning (don't have to overly worry about headers, status)

  NOT_FOUND = lambda { |env|
    [
      404,
      {'Content-Type' => 'text/html'},
      'Not Found'
    ]
  }
  use Rack::Directory :root => 'path/to/app/public' #serve static assets
  use MyApplication::Catalog
  use MyApplication::Cart
  use MyApplication::MyAccount
  run NOT_FOUND

## Ri
- Transcendence of web-frameworks in general
- Understand how the abstractions work
- We can decide when Rails is the tool for the job, and when it doesn't

## Takeaways
- The complete beginner: This path is dogma
- I'm already doing X: Do this Code Retreat style
- I'm a master: consider teaching your apprentices this

- You're no longer stuck with Rails
- You have the knowledge and experience to choose
  - Can use rack middleware to prevent the whole rails stack being used for basic requests (Capcha)

## Challenges
- cgiup
- RFC 2616 - loop at HTTP/1.1 protocol

## Books
- _Mastery_ by George Leonard
- _The Art of Learning_ by Josh Waitzkin
- _Agile Software Development: The Cooperative Game_ by Alistair 
