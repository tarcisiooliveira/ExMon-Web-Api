defmodule ExMon.TrainerTest do
  use ExMon.DataCase
  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{name: "Tarcisio", password: "123456"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Tarcisio",
                 password: "123456"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } =
               response
    end

    test "when there are invalid params, return a invalid changeset" do
      params = %{password: "123456"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123456"
               },
               data: %ExMon.Trainer{},
               valid?: false
             } =
               response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  test "when all params are valid, return a valid trainer struct" do
    params = %{name: "Tarcisio", password: "123456"}
    response = Trainer.build(params)
    assert {:ok, %{name: "Tarcisio", password: "123456"}} = response
  end

  test "when there are invalid params, return an invalid changeset" do
    params = %{password: "123456"}
    {:error, response} = Trainer.build(params)
    assert %Ecto.Changeset{} = response
    assert errors_on(response) == %{name: ["can't be blank"]}
  end
end
