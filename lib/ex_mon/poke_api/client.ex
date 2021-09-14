defmodule ExMon.PokeApi.Client do
  @moduledoc """
  Module Doc Name
  """
  use Tesla

  @doc """
    Modulo que irá fazer a conexão com API externa
    Tesla é o módulo que faz a conexão
  """

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  def handle_get({:ok, %Tesla.Env{status: 404}}), do: {:error, "Pokemon Not Found"}
  def handle_get({:error, _reason} = error), do: error
end
