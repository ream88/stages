defmodule Stages.Producer do
  use GenStage
  require Logger

  def start_link(_) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def notify(limit \\ 1) do
    1
    |> Range.new(limit)
    |> Enum.each(fn number ->
      GenStage.cast(__MODULE__, IO.inspect({:notify, "event_#{number}"}))
    end)
  end

  # GenStage API

  def init(_) do
    {:producer, :ok}
  end

  def handle_cast({:notify, event}, state) do
    IO.inspect({:noreply, [event], state})
  end

  def handle_demand(demand, state) do
    Logger.debug("#{__MODULE__} incoming demand: #{demand}")
    # We don't care about the demand
    {:noreply, [], state}
  end
end
