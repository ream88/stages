defmodule Stages.Consumer do
  use GenStage
  require Logger

  def start_link(number) do
    GenStage.start_link(__MODULE__, number)
  end

  # GenStage API

  def init(number) do
    {:consumer, number, subscribe_to: [{Stages.Producer, max_demand: 1}]}
  end

  def handle_events(events, _from, number) do
    Logger.debug("#{__MODULE__} ##{number} incoming events: #{inspect(events)}")
    # Simulate long running task
    500..1500 |> Enum.random() |> :timer.sleep()
    {:noreply, [], number}
  end
end
