defmodule ExMonWeb.Auth.Guardian do
  @moduledoc """
  Module Doc Name
  """
  use Guardian, otp_app: :ex_mon

  alias ExMon.Repo
  alias ExMon.Trainer

  def subject_for_token(trainer, _claims) do
    sub = to_string(trainer.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"trainer_id" => trainer_id, "password" => password}) do
    case Repo.get(Trainer, trainer_id) do
      nil -> {:error, "Trainer not found"}
      trainer -> validate_password(trainer, password)
    end
  end

  def validate_password(%Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claim} = encode_and_sign(trainer)
    {:ok, token}
  end
end
