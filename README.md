# ExFlag

Goals:
* Retrieve a value from a server for a known _key_ with optional host parameters
 * This may include host name, environment, version, etc...
* Value is an atom (on / off, a / b / c, etc)

Non-Goals (right now)
* Provide offline storage / caching of keys

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exflag` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exflag, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exflag](https://hexdocs.pm/exflag).
