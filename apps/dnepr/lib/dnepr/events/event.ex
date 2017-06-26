defmodule Dnepr.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dnepr.Events.Event


  schema "events_events" do
    field :location, :string
    field :name, :string
    field :visitors, :integer

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :location, :visitors])
    |> validate_required([:name, :location, :visitors])
  end
end
