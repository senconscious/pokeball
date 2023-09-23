defmodule PokeballTest do
  use ExUnit.Case
  doctest Pokeball

  test "greets the world" do
    assert Pokeball.hello() == :world
  end
end
