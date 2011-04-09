# Martyn & Eventmachine

## Worked On
- Panda - hosted video encoding
- Pusher - hosted real-time messaging

## Redis
- Advanced k-v store
- Data structure server
- Grab bag of algorithms

## Stories
- Auto assignment of roles w/ locking
- Async comms
- Shared state synchronization

## @ Pusher
- Messages sent to browsers through sockets & web-sockets
- Could use Redis for stats/logs
- Want to transfer redis data to SQL database

### But
- can't have multiple transfers concurrently
- but can't have failure either (missing data)
- don't want to configure it
- "Best way to fail, is to fail constantly." Netflix on AWS

### Distributed Lock
- Google decided not to use a distributed consensus protocol
- Easier to use a central lock

### Locking in Redis

    setnx mylock 1302311263 #=> set this key to a timestamp if it's not set already
    returns 1 (succeeded, I've got the lock)
    returns 0 (already locked)

### How do we handle deadlocks?
- Locking process might die
- Lock has a timestamp, that has an expiry time
- If timestamp has passed when I try to set a new lock, I can try and get the lock

### Transactions
- Redis uses optimistic locking
- Redis has transactions

    multi #start a transaction
    # transactional commands
    exec  #execute all the commands as one


### Eventmachine & Redis

    em-hiredis

- callbacks & errorbacks on the redis op completion

### BASICALLY
- we can set a lock by setting a key to a timestamp sometime in the future
- problems if we die before releasing the lock
- we need to start a new process if the old process dies but not before
- so put it in an EM loop (check every 10 seconds to check/set the lock & start up a new process if we have to)

## Async Comms
- Queueing up video encoding
- Classic queueing (Delayed::Job) but seperate queues for each user
- Not obvious which encoder should pick up new jobs
- Async comms between the manager, and the encoders
  - Status =>
    <= Busy
  - Complete
- Solved it using redis lists
- Blocking-RPOP

## Synchronizing shared state
- Sorted Sets - every element has a score
- Redis Pub/Sub
  - Subscribe to a change in information
  - Any process that's interested can subscribe to information about that change

