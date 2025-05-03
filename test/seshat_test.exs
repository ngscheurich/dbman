defmodule DbmanTest do
  use ExUnit.Case
  doctest Dbman

  test "greets the world" do
    assert Dbman.hello() == :world
  end
end
