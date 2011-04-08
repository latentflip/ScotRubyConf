# Profiling @chastell
# profiling-ruby-src-2011.heroku.com

- Ruby's 'Performance'
- shootout.alioth.debian.org
- Developer time is more important than computer time

## Algorithms & Architectures are more important than the language

## Profiling Ruby

    require 'profile'
    time ruby -r proofile grid.rb 9
    # but adds 100 times slower when profiling

    time ruby-prof grid.rb 9
    # three times slower

    gem install perftools.rb
    export CPUPROFILE=grid
    time ruby -r perftols grid.rb 9
    # almost no overhead
    pprof.rb --text grid
    pprof.rb --pdf profile > profile.pdf

## perftools.rb
- pings 4000 times per sec 
- reads what's at the top of the callstack
- statistical profiling

## A few months in the laboratory can save a couple of hours in the library

## Rewrite in c

    require 'inline'
    #inline builder

## Rack based profiling

    export CPUPROFILE=profile
    rackup -r perftools

    $ ab -n 10 http://localhost:9292

    pprof.rb --pdf profile > profile.pdf

## Speeding up ruby

- different ruby implementations
- fast libraries
  - NArray / Ruby/GSL / ruby-boost-regex / google_hash

- gem install levenshtein
  - written in both c and ruby
  - optimized C
  - everything else c
  - if no c, ruby

# Embedding Foreign Languages

- RubyInline
- JavaInline (Java)
- Hubris (Haskell)

# Improving
- Profile
- Optimise algorithms
- Rewrite last
- Look for solved before

# Automagic Ruby-to-C translators

