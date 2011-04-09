# Front End Testing

## Javascript testing is neglected
- Ruby testing in rails projects is _fill in the blanks_

## We don't treat JS like real code

## We test JS for the same reasons as ruby

## Unit vs Integration

### Unit Testing
- testing widgets/components
- isolated logic
- don't necessarily need rails/backend

### Integration Testing
- testing glue code (AJAX)
- complex DOM


## Integration Testing
### Current Approach to Integration Testing
- Rails integration tests
  - Written from an HTTP perspective
  - Doesn't do what the user does
    - Don't know if they can see the form
    - If the fields are correct
    - If it posts to the right place
- So we got Webrat
  - Written from a user perspective
  - But limited JS support (through selenium)
- Selenium
  - Full stack testing
  - but unnecessary overhead
  - hard to setup

### What do we need
- Easy setup
- Multiple ways of running tests
  - Ruby only
  - JS (user)

### Resulted in Capybara
- Simulates user behaviour
- Similar DSL to webrat

### Seamlessly switch between drivers
- rack-test
- selenium
- akephalos
- capybara-envjs

## Unit Testing
- Hard
- Code ends up in your project
- No established best practice
- Hard to maintain
- Lack of isolation of tests  
  - One test can affect another
- Unstable test frameworks

### What do we need
- Easy setup
- Opinionated solution
- Well packaged - standalone as possible
  - No setup
  - Should not add any files to the project
  - Easy to update
  - i.e. a ruby gem
- Easy to run
  - In a browser
  - From the commandline, easy to integrate into workflow
  - Against multiple drivers

### Solution
- The best testing framework: Jasmin
  - Stable
  - Small but full featured
  - General purpose
- Well packaged: Evergreen
  - No generators, setup, no code
  - Works great with rails
  - Not tied to rails
  - Nice syntax via coffeescript
  - Templates
    - End up with lots of glue code
    - So instead use template fragments
      - Reloaded
      - Isolated
- Runs from /evergreen
- Runs from the commandline

### Resources 
- (Front End Testing)[http://github.com/elbas/front_end_testing]

