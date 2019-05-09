defmodule ApppWeb.Router do
  use ApppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth_api do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: Appp.Guardian,
      error_handler: Appp.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/", ApppWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ApppWeb do
    pipe_through :api
    resources "/users", UserController, only: [:create]
    post "/login_drawer", AuthController, :login_drawer
    pipe_through :auth_api
    resources "/users", UserController, except: [:create]
  end
end
