defmodule Scs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ScsWeb.Telemetry,
      # Start the Ecto repository
      Scs.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Scs.PubSub},
      # Start Finch
      {Finch, name: Scs.Finch},
      # Start the Endpoint (http/https)
      ScsWeb.Endpoint
      # Start a worker by calling: Scs.Worker.start_link(arg)
      # {Scs.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
