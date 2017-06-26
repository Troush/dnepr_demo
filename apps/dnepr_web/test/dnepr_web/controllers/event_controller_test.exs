defmodule Dnepr.Web.EventControllerTest do
  use Dnepr.Web.ConnCase

  alias Dnepr.Events
  alias Dnepr.Events.Event

  @create_attrs %{location: "some location", name: "some name", visitors: 42}
  @update_attrs %{location: "some updated location", name: "some updated name", visitors: 43}
  @invalid_attrs %{location: nil, name: nil, visitors: nil}

  def fixture(:event) do
    {:ok, event} = Events.create_event(@create_attrs)
    event
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates event and renders event when data is valid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, event_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "location" => "some location",
      "name" => "some name",
      "visitors" => 42}
  end

  test "does not create event and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen event and renders event when data is valid", %{conn: conn} do
    %Event{id: id} = event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, event_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "location" => "some updated location",
      "name" => "some updated name",
      "visitors" => 43}
  end

  test "does not update chosen event and renders errors when data is invalid", %{conn: conn} do
    event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen event", %{conn: conn} do
    event = fixture(:event)
    conn = delete conn, event_path(conn, :delete, event)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, event)
    end
  end
end
