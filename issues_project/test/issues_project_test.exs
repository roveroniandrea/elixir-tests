defmodule IssuesProjectTest do
  use ExUnit.Case
  doctest IssuesProject

  test "greets the world" do
    assert IssuesProject.hello() == :world
  end
end
