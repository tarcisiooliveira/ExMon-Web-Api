defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  alias ExMon.Trainer

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer Created ",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("view.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at,
          pokemon: pokemon
        }
      }) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at,
      pokemon: parse_type(pokemon)
    }
  end

  def render("update.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at, updated_at: updated_at}
      }) do
    %{
      message: "Trainer Updated ",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  defp parse_type(pokemons), do: Enum.map(pokemons, fn item -> item.name end)
end
