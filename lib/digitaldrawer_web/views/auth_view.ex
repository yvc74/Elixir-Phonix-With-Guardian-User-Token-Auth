defmodule DigitaldrawerWeb.AuthView do
  use DigitaldrawerWeb, :view
  alias DigitaldrawerWeb.AuthView

  def render("login_drawer.json", %{user: user, token: token}) do
    %{
      data: %{
        user: %{
          id: user.id,
          username: user.username,
          age: user.age,
          email: user.email
        },
        token: token
      }
    }
  end
end
