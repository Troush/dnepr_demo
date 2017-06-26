defmodule Dnepr.Web.EventView do
  use Dnepr.Web, :view
  alias Dnepr.Web.EventView

  def render("error.json", _) do
    %{error: "token invalid"}
  end

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      location: event.location,
      visitors: event.visitors}
  end
end
