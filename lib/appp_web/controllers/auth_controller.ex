defmodule ApppWeb.AuthController do
  use ApppWeb, :controller
  alias Appp.{Accounts, Guardian}
  alias Appp.Accounts.User

  def login_drawer(conn, %{"login" => login_params}) do
    IO.inspect(login_params)

    with {:ok, %User{} = user} <- Accounts.user_auth(login_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:accepted)
      |> render("login_drawer.json", %{user: user, token: token})
    else
      {:error, message} ->
        conn
        |> put_view(ApppWeb.ErrorView)
        |> render("login_drawer_error.json", message: message)
    end
  end
end
