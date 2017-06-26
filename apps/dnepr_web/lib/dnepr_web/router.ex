defmodule Dnepr.Web.Router do
  use Dnepr.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Dnepr.Web do
    pipe_through :api
    resources "/events", EventController, except: [:new, :edit]
  end
end
