defmodule ExMon.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock

  alias ExMon.PokeApi.Client
  @base_url "https://pokeapi.co/api/v2/pokemon/"
  describe "get_pokemon/1" do
    test "when theres a pokemon with the given name, returns the pokemon" do
      body = %{"name" => "pikachu", "weight" => 60, "types" => ["eletric"]}
      # na linha abaixo, é setado o metodo que deverá ser usado e a url a ser chamado
      # esse valores são validados com patter matching, verificando se os
      # metodos foram realmente esses utilizados
      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        # é retornado o que nós queremos retornar, no caso, o body setado acima
        # esse parametros "%Tesla.Env{status: 200, body: body}" são os mesmo encontrados
        # em handle_get de ExMon.PokeApi.Client", que é a classe de teste
        # chamado pelo método Client.get_pokemon("pikachu")
        %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")
      expected_response = {:ok, %{"name" => "pikachu", "types" => ["eletric"], "weight" => 60}}
      assert response == expected_response
    end

    test "when there's no pokemon with the given name, returns the pokemon" do
      # O valor  valor da função Clien.get_pokemon deve ser igual ao valor concatenado com a url
      # pois a simulação do mock é com base no valor concatenado
      mock(fn %{method: :get, url: @base_url <> "banana"} ->
        %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("banana")
      expected_response = {:error, "Pokemon Not Found"}
      assert response == expected_response
    end

    test "when there's an expected error, returns the error" do
      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("pikachu")
      expected_response = {:error, :timeout}
      assert response == expected_response
    end
  end
end
