defmodule ExFlag.FlagRequest do
  # @type flag_value() :: any()
  # @type flag_key() :: atom() || String.t()
  # @type flag_options() :: map()

  @doc "Get a flag from the provided endpoint."
  #@spec get_server_key(cache_value :: flag_value(), key :: flag_key) :: {atom(), atom()}
  def get_server_key(nil, endpoint, key, opts) do
    data = %{key: key, opts: opts}
    resp = HTTPoison.post(endpoint, Poison.encode!(data), [{"Content-Type", "application/json"}])

    get_server_response(resp)
  end

  def get_server_key(value, _, _, _), do: {:cached, value}

  defp get_server_response(resp) do
    case resp do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_server_response(body)}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:invalid_flag, :off}
      {:ok, _} ->
        {:invalid_request, :off}
      {:error, reason} ->
        {:failed_request, :off}
    end
  end

  defp parse_server_response(body) do
    {:ok, %{"value" => value}} = Poison.decode(body)
    String.to_atom(value)
  end
end
