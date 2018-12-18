defmodule ExFlag do
  @moduledoc """
  Documentation for ExFlag.
  """

  alias ExFlag.FlagRequest

  @endpoint Application.get_env(:exflag, :endpoint)

  def start_link(_, name \\ __MODULE__) do
    Agent.start_link(fn -> %{} end, name: name)
    Agent.start_link(fn -> %{} end, name: :ex_flag_values)
  end

  def set_opts(opts, pid \\ __MODULE__) do
    Agent.update(pid, fn(_) -> opts end)
  end

  def get_opts(pid \\ __MODULE__) do
    Agent.get(pid, &(&1))
  end

  def is_enabled?(key, opts \\ %{}) do
    case get_flag(key, opts) do
      nil ->
        false
      :off ->
        false
      _ ->
        true
    end
  end

  @doc "Retrieve a flag from the server"
  @spec get_flag(key :: String.t, opts :: list(String.t)) :: atom
  def get_flag(key, opts \\ %{}) do
    # Concatenate system opts with the metric opts
    key_opts = Map.merge(get_opts(), opts)
    # Check local cache with key and opts
    {_reason, value} = get_cache_key(key, key_opts)
    # Check server with key and opts
    # If server isn't connected, use default (:off)
    # If key isn't on server, use default (:off)
    # If key is on server, convert to atom and return
    # server endpoint defined in config
      |> FlagRequest.get_server_key(@endpoint, key, key_opts)

    set_cache_key(key, value, key_opts)

    value
  end

  @doc "Invalidate a single flag."
  @spec invalidate_flag(key :: String.t, opts :: list(String.t)) :: :ok
  def invalidate_flag(key, opts \\ %{}) do
    Agent.update(:ex_flag_values, &Map.delete(&1, {key, opts}))
  end

  @doc "Invalidate all flags."
  def invalidate_flags() do
    Agent.update(:ex_flag_values, fn(_) -> %{} end)
  end

  defp get_cache_key(key, opts) do
    Agent.get(:ex_flag_values, &Map.get(&1, {key, opts}))
  end

  defp set_cache_key(key, value, opts) do
    Agent.update(:ex_flag_values, &Map.put(&1, {key, opts}, value))
  end
end
