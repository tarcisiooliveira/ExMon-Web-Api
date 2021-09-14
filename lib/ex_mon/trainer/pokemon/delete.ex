defmodule ExMon.Trainer.Pokemon.Delete do
  @moduledoc """
  Module Doc Name
  """
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer.Pokemon}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID Format"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Pokemon Not Found"}
      trainer -> Repo.delete(trainer)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Pokemon, uuid)
end
