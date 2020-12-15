defmodule ExMon.Trainer.Get do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID Format"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Invalid ID Not Found"}
      trainer -> {:ok, trainer}
    end
  end
end