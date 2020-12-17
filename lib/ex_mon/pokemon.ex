defmodule ExMon.Pokemon do
  @keys [:id, :name, :weight, :types]

  @enforce_keys @keys

  @derive Jason.Encoder

  defstruct @keys

  @moduledoc """
   iex>  {:ok, pokemon} = ExMon.PokeApi.Client.get_pokemon("scyther")
   iex>  ExMon.Pokemon.build(pokemon)
   %ExMon.Pokemon{id: 123, name: "scyther", types: ["bug", "flying"], weight: 560}
  """

  def build(%{"id" => id, "name" => name, "weight" => weight, "types" => types}) do
    %__MODULE__{
      id: id,
      name: name,
      weight: weight,
      types: parse_type(types)
    }
  end

  # aqui o item["type"]["name"]é por conta de haver uma outra estrutura com o "Type" dentro do "types" e um "name" dentro dentro do "type"
  defp parse_type(types), do: Enum.map(types, fn item -> item["type"]["name"] end)
end
