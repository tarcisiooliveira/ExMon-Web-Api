defmodule ExMon.Pokemon.Get do
  alias ExMon.PokeApi.Client
  alias ExMon.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon()
    |> handle_response()
  end

  defp handle_response({:ok, body}) do
    IO.puts("passou cima")
    {:ok, Pokemon.build(body)}
  end

  defp handle_response({:error, _reason} = error), do: error
end
