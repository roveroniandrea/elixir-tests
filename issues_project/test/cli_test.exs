# Test modules should not be prefixed?

defmodule CliTest do
  use ExUnit.Case
  # Testing the IssuesProject project
  doctest IssuesProject

  # importing module to test and only what needs to be tested
  import IssuesProject.CLI, only: [parse_args: 1]

  # Tests here

  # Syntax is `test <test_description> do ... end
  test ":help should be returned when passing --help or -h options" do
    # Assert some condition to be true
    assert parse_args(["-h", "Something else"]) == :help
    assert parse_args(["--help", "Something else"]) == :help
  end

  test "Three values returned if three given" do
    assert parse_args(["roveroniandrea", "elixir-tests", "99"]) ==
             {"roveroniandrea", "elixir-tests", 99}
  end

  test "Count is defaulted if given two values" do
    assert parse_args(["roveroniandrea", "elixir-tests"]) ==
             {"roveroniandrea", "elixir-tests", 4}
  end
end
