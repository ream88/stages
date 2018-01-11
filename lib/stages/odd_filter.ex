defmodule Stages.OddFilter do
  use GenStage
  require Integer

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
    {:noreply, events, state}
  end
end
