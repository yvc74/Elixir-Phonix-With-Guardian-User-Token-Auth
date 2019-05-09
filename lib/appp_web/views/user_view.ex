defmodule ApppWeb.UserView do
  use ApppWeb, :view
  alias ApppWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user_creation.json", %{user: user, token: token}) do
    %{
      data: %{
        id: user.id,
        username: user.username,
        age: user.age,
        email: user.email,
        token: token
      }
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      age: user.age,
      email: user.email
    }
  end
end
