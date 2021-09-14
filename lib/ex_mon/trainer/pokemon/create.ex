defmodule ExMon.Trainer.Pokemon.Create do
  @moduledoc """
  Module Doc Name
  """
  alias ExMon.PokeApi.Client
  alias ExMon.Pokemon
  alias ExMon.Repo
  alias ExMon.Trainer.Pokemon, as: TrainerPokemon

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:error, _reason} = error, _params), do: error

  def create_pokemon(%Pokemon{name: name, weight: weight, types: types}, %{
        "nickname" => nickname,
        "trainer_id" => trainer_id
      }) do
    params = %{
      name: name,
      weight: weight,
      types: types,
      nickname: nickname,
      trainer_id: trainer_id
    }

    params
    |> TrainerPokemon.build()
    |> handle_build()
  end

  defp handle_build({:ok, pokemon}), do: Repo.insert(pokemon)
  defp handle_build({:error, _reason} = error), do: error
end
