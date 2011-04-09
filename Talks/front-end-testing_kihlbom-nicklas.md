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

## Capybara

### Current Approach
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
  - 
