defmodule Dnepr.Application do
  @moduledoc """
  The Dnepr Application Service.

  The dnepr system business domain lives in this application.

  Exposes API to clients such as the `Dnepr.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Dnepr.Repo, []),
    ], strategy: :one_for_one, name: Dnepr.Supervisor)
  end
end
