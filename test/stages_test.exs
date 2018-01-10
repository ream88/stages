defmodule StagesTest do
  use ExUnit.Case
  doctest Stages

  test "greets the world" do
    assert Stages.hello() == :world
  end
end
