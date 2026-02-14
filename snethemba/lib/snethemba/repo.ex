defmodule Snethemba.Repo do
  use Ecto.Repo,
    otp_app: :snethemba,
    adapter: Ecto.Adapters.Postgres
end
