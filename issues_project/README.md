# IssuesProject
This Elixir project will use Github API to retrieve a list of n oldest issues of a repository

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `issues_project` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:issues_project, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/issues_project>.

# Mix
Mix is a command line utility that manages Elixir projects. It comes installed along Elixir
- `mix help` Shows help
- `mix new <path>` Creates a new project under path

## Project files
- `.formatter.exs` Configuration used by source code formatter
- `config/` Optional project config folder
- `lib/` Project source directory, with an initial top level module already added
- `mix.exs` Project's configuration options
- `test/` Folder for storing test files

## Project modules
### IssuesProject.CLI and Elixir conventions
By convention, this is how should be called the module that handles command line interface. The entry point should be a `run()` function that takes an array of program arguments as input.

Also, Elixir modules should be under `lib/<project_name>`, so `lib/issues_project/cli.ex` in this case, one module per file. Not that they're `.ex` files, not `.exs`


## Testing
Mix comes with a testing framework called `ExUnit`. Default `<project_name>_test.exs` file acts as a boilerplate.
Tests are defined under `test/` folder. Naming should be `test/<module_name>_test.exs`. Note `.exs` file
Use `mix test` to run tests, or VS Code task. Optionally `--trace` flag for showing a complete list of runned tests.
In case an assertion fails, Mix shows the left and right side of the code that failed (for example an equality check)