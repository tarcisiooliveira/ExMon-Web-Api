defmodule ExMonWeb.Auth.ErrorHandler do
  @moduledoc """
  Module Doc Name
  """
  import Plug.Conn
  @behaviour Guardian.Plug.ErrorHandler

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
