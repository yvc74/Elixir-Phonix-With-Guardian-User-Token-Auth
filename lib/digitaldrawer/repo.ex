defmodule Digitaldrawer.Repo do
  use Ecto.Repo,
    otp_app: :digitaldrawer,
    adapter: Ecto.Adapters.Postgres
end
