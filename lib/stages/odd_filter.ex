defmodule Stages.OddFilter do
  use GenStage
  require Integer
  require Logger

  def start_link(), do: start_link([])

  def start_link(_) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def subscribe(to) do
    selector = fn event ->
      event
      |> String.replace_prefix("event_", "")
      |> String.to_integer()
      |> Integer.is_odd()
    end

    GenStage.sync_subscribe(__MODULE__, to: to, selector: selector, max_demand: 1)
  end

  # GenStage API

  def init(state) do
    {:producer_consumer, state}
  end

  def handle_events(events, _from, state) do
    Logger.debug("#{__MODULE__} forwarding events: #{inspect(events)}")
    # Simulate long running task
    500..1500 |> Enum.random() |> :timer.sleep()
    {:noreply, events, state}
  end
end
