#PCI DSS with Ryan Stenhouse

## Basics
- security standard that everyone who deals with credit card information has to deal with
- complicated & annoying, defeatable with common-sense & planning
- can't be ignored, can be costly

## Topics
- self-assessment compliance
  - fill out a piece of paper to say you are compliant

## Self Assessment
- taking payments online, less than a certain volume
- tick a few boxes, no auditor needed
  - SAQ A (basic one)
  - SAQ C (more complex)
- SAQ A
  - if you outsource all card processing, and never touch data, you're handing over all the risk to paypal
  - 13 questions
- SAQ C
  - if using active_merchant (accepting, handling, passing off data) need this
  - 80 questions
  - lots of documentation to write

## As a developer
- SAQ A
  - nothing to worry about
- SAQ C
  - org level docs, saying what you are adhering to and following
  - need to know OWASP's top ten
  - more code, more docs

## As a sysadmin
- SAQ A
  - nothing to worry about
- SAQ C
  - lots of stuff to do around packages, updates, testing etc
  - not too bad when up and running

## As a business
- Can stop you taking cards as a worst case, fine you
- Lots of docs
- Must be PCI DSS compliant

## Quick wins
- Go for SAQ A unless your have to (volume/billing experience)
- Outsource as much as you can (even the PCI stuff) if you can
- Kill WiFi?

## Bear Traps
- PCI logging is hard to follow
- Can't always segregate responsibilities as you'd like
- Quarterly ASV scans, Pen. Tests every time you make a network change

## Change Management
- Documented procedure for your applications
- Rollbacks, testing etc strategy
- Lots of paperwork (every change)

## FIM / IDS
- OSSEC does intrusion monitoring/file change

## Logging
- Is very hard
  - centralised
  - protected
  - offsite
- rsyslogd is good enough, if well documented

## Misc Advice
- VM's are okay for PCI
- You need to identify and isolate ALL cardholder data
  - Consolidate it to one place
- If in doubt, hire a QSA for the day (expensive)
