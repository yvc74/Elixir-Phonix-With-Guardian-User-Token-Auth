defmodule Appp.Repo do
  use Ecto.Repo,
    otp_app: :appp,
    adapter: Ecto.Adapters.MySQL
end
