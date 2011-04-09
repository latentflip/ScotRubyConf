# Don't build another tower of babel

## Lessons from the Tower of Babel
- Language - congnitive ability to form & communicate concepts
- Speech is not language - no syntax in speech itself

### ActiveRecord
- Makes it easy to get and set data in the database
- But leads to CRUDdy applications
- ActiveRecord's language is not domain specific

### Domain specific

    @trade = Trade.new(params[:trade])

    if @trade.save
      ...
    end

- What does Trade new mean?
- What does Trade save actually mean? Do brokers actually save trades

### Active Record

> "An object that wraps a row in a db table or view, encapsulatese the db access, and adds _domain_ logic on the data."

- In a way this defies the Single Responsibility Principle
  - Works in the application domain
  - But you can also reach into the database

### Domain Model

> "An object model of the domain that incorporates both behaviour and data."

    Appointment.book_on(date)

    Subscriber.provision_new(data_plan)

### Rewrite

    @trade = Trade.book(params[:trade])

    if @trade.booked?
      ...
    end

### Tips
- Encapsulate AR calls into the domain models
  - The only object allowed to use ActiveRecord methods, is internal to the model
  - A graph of domain objects working together
- Use named scopes

## Hubris
- Arrogance
- Being out of touch with reality
- We listen to customer, and then say "what they _really_ mean is ..."

### Avoiding Hubris
- Ask stupid questions
  - Even though there is no such thing
- Keep communicating with your customers, keep talking, keep taking notes
- Get into their world

> "In order to solve a problem, I need to understand it pretty well, no matter how good I am at solving problems."

## Cucumber

- Wrong
    l
    Given I am on '/calendar'
    And I click ...
    And I fill in ...
    And I click ...
    Then ...

- Better

    Given I am a forgetful person
    When I create a new event on my calendar
    Then my event should appear in my calendar

  - Not focussing on technology
  - Focussing on the language of the customer

## Finally
- Don't expose ActiveRecord
- Talk & listen to your customers
- Cucumber: not a testing framework, but a documentation framework
  > I am writing documentation to my customer, and if that is executable, then that is a win

## More Reading
- Read Dan North's blog posts about Cucumber
