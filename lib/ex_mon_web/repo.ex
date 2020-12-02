defmodule ExMonWeb.Repo do
  use Ecto.Repo,
    otp_app: :ex_mon_web,
    adapter: Ecto.Adapters.Postgres
end
