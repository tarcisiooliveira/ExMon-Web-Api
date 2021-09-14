defmodule ExMon.Trainer.Update do
  @moduledoc """
  Module Doc Name
  """
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID Format"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Trainer Not Found"}
      trainer -> update_trainer(trainer, params)
    end
  end

  def update_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end
end
