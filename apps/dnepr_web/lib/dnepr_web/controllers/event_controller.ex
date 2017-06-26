defmodule Dnepr.Web.EventController do
  use Dnepr.Web, :controller

  alias Dnepr.Events
  alias Dnepr.Events.Event

  action_fallback Dnepr.Web.FallbackController

  def index(conn, %{"token" => nil}) do
    render(conn, "error.json")
  end
  def index(conn, params = %{"token" => "", "users" => []}) when is_list(params.users) do
    render(conn, "error.json")
  end

  def index(conn, %{"token" => token}) do
    "12345" = token
    events = Events.list_events()
    render(conn, "index.json", events: events)
  end

  def index(conn, _params) do
    # "12345" = token
    # events = Events.list_events()
    render(conn, "error.json")
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Events.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event!(id)

    with {:ok, %Event{} = event} <- Events.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    with {:ok, %Event{}} <- Events.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
