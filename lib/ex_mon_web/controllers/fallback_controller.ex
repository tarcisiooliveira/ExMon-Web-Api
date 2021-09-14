defmodule ExMonWeb.FallbackController do
  use ExMonWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    # serve para exibir o erro passado sem precisar criar uma view
    |> put_view(ExMonWeb.ErrorView)
    # com o mesmo nome do controller(Fallback_controller), por isso o put_view
    |> render("401.json", message: "Trainer not authorized")
  end

  # Toda FallbackController define uma função call, ela recebe todo os erros que são passado
  # pelo controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    # serve para exibir o erro passado sem precisar criar uma view
    |> put_view(ExMonWeb.ErrorView)
    # com o mesmo nome do controller(Fallback_controller), por isso o put_view
    |> render("400.json", result: result)
  end
end
