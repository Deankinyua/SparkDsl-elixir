defmodule SparkdslTest do
  use ExUnit.Case
  doctest Sparkdsl

  test "greets the world" do
    assert Sparkdsl.hello() == :world
  end
end
