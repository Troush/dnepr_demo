defmodule Dnepr.Repo.Migrations.CreateDnepr.Events.Event do
  use Ecto.Migration

  def change do
    create table(:events_events) do
      add :name, :string
      add :location, :string
      add :visitors, :integer

      timestamps()
    end

  end
end
