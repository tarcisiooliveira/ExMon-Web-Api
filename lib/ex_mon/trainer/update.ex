defmodule ExMon.Trainer.Update do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID Format"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Invalid ID Not Found"}
      trainer -> update_trainer(trainer, params)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  def update_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end
end
