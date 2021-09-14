defmodule ExMon.Trainer.Pokemon.Get do
  @moduledoc """
  Module Doc Name
  """
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer.Pokemon}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Pokemon Not Found"}
      {:ok, uuid} -> get(uuid)
    end
  end

  @doc """
  A função Repo.preload(pokemon, :trainer), trás as informações também dos treinadores associado aquele pokemon

  """
  defp get(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Invalid ID Format"}
      pokemon -> {:ok, Repo.preload(pokemon, :trainer)}
    end
  end
end
