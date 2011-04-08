# Beautiful Mac Apps in MacRuby

## Objective-C
- Objective-C Looks Ugly To Me
- Verbose

## MacRuby
- Just another ruby
- Runs on Obj-C Runtime
- First-Class citizen to Apple
- Seamless access to Obj-C
- Pretty fast
- DSL library called HotCocoa (Programmatic UI building)

## Macruby is Ruby & A Little More
- MacRuby commands called with mac*
  - macirb
  - macruby

- Scripting Bridge

    framework 'ScriptingBridge'
    itunes = SBApplication.applicationWithBundleIdentifier('com.apple.iTunes')

    itunes.currentTrack.methods(true,true) - Object.methods(true,true) #available methods
    itunes.playpause

## Building a view

- Programmatically or Interface Builder

## Stuff

- AppDelegate
- rb_main.rb
  - invoked from main.m
- Resources/something -> interface builder


# On Github
https://github.com/bsbodden/MacRubyBrowser
