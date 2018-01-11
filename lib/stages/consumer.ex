defmodule Stages.Consumer do
  use GenStage
  require Logger

  def start_link(name) do
    GenStage.start_link(__MODULE__, [name])
  end

  def subscribe(pid, to) do
    GenStage.sync_subscribe(pid, to: to, max_demand: 1)
  end

  # GenStage API

  def init(name) do
    {:consumer, name}
  end

  def handle_events(events, _from, name) do
    Logger.debug("#{__MODULE__} \"#{name}\" incoming events: #{inspect(events)}")
    # Simulate long running task
    500..1500 |> Enum.random() |> :timer.sleep()
    {:noreply, [], name}
  end
end
