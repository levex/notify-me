defmodule NotifyMeWeb.Router do
  use NotifyMeWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    #plug :fetch_session
    #plug :fetch_flash
    #plug :protect_from_forgery
    #plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NotifyMeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/create", PageController, :create_new_id
    get "/check/:uuid", PageController, :get_notification
    post "/send/:uuid", PageController, :send_notification
  end

  # Other scopes may use custom stacks.
  # scope "/api", NotifyMeWeb do
  #   pipe_through :api
  # end
end
