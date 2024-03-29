defmodule ExMon.Trainer do
  @moduledoc """
  Module Doc Name
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExMon.Trainer.Pokemon
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:pokemon, Pokemon)
    timestamps()
  end

  # %{name: "Tarcisio", password_hash: "123456"}|>ExMon.Trainer.changeset()
  # Ecto.Changeset<
  #   action: nil,
  #   changes: %{name: "Tarcisio", password_hash: "123456"},
  #   errors: [],
  #   data: #ExMon.Trainer<>,
  #   valid?: true
  # >

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:name, :password]
  # Usado pelo create
  def changeset(params), do: create_or_change_changeset(%__MODULE__{}, params)
  # usado pelo update
  def changeset(trainer, params), do: create_or_change_changeset(trainer, params)

  defp create_or_change_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
