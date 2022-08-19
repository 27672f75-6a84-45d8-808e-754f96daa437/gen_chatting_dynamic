defmodule GenChattingDynamicTest do
  use ExUnit.Case
  doctest GenChattingDynamic

  test "greets the world" do
    assert GenChattingDynamic.hello() == :world
  end
end
