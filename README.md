# Stages

A simple demonstration of GenStage's producer and consumer
implementing a job queue.

```elixir
# Generate a few consumers, each with its unique id:
Stages.Consumer.start_link(1)
# ...
Stages.Consumer.start_link(5)

# Generate work (or 100 events):
Stages.Producer.notify(100)
```
