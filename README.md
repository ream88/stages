# Stages

A simple demonstration of GenStage's producer and consumer
implementing a job queue.

```elixir
alias Stages.{Producer, Consumer}

# Generate a few consumers, each with its unique id:
{:ok, first} = Consumer.start_link("first")
{:ok, second} = Consumer.start_link("second")

Consumer.subscribe(first, Producer)
Consumer.subscribe(second, Producer)

# Generate work (or 10 events):
Producer.notify(10)
```

`OddFilter` is implemented as a producer consumer which filters odd events:

```elixir
alias Stages.{Producer, Consumer, OddFilter}

# Generate a few consumers, each with its unique id:
{:ok, all} = Consumer.start_link("all")
{:ok, odd} = Consumer.start_link("odd")

Consumer.subscribe(all, Producer)
OddFilter.subscribe(Producer)
Consumer.subscribe(odd, OddFilter)

# Generate work (or 10 events):
Producer.notify(10)
```
