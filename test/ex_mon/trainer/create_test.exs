defmodule ExMon.Trainer.CreateTeste do
  alias ExMon.{Repo, Trainer}
  alias Trainer.Create
  use ExMon.DataCase

  describe "call/1" do
    test "when all params are valid, create a trainer" do
      params = %{name: "Tarcisio", password: "987654"}
      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)
      assert {:ok, %Trainer{name: "Tarcisio"}} = response
      assert count_after > count_before
    end

    test "when there are invalid params, return the error" do
      params = %{name: "Tarcisio"}
      response = Create.call(params)
      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
