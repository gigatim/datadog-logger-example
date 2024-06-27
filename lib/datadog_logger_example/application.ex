defmodule DatadogLoggerExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DatadogLoggerExampleWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:datadog_logger_example, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DatadogLoggerExample.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DatadogLoggerExample.Finch},
      # Start a worker by calling: DatadogLoggerExample.Worker.start_link(arg)
      # {DatadogLoggerExample.Worker, arg},
      # Start to serve requests, typically the last entry
      DatadogLoggerExampleWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DatadogLoggerExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DatadogLoggerExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
