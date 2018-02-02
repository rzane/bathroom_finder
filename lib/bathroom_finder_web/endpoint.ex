defmodule BathroomFinderWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bathroom_finder

  socket "/socket", BathroomFinderWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :bathroom_finder, gzip: false,
    only: ~w(assets)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_bathroom_finder_key",
    signing_salt: "JAZRIU5c"

  plug BathroomFinderWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      config =
        config
        |> Keyword.put(:http, [:inet6, port: get_port()])
        |> Keyword.put(:server, server_enabled?())

      {:ok, config}
    else
      {:ok, config}
    end
  end

  defp get_port do
    System.get_env("PORT") || raise "expected the PORT environment variable to be set"
  end

  defp server_enabled? do
    if System.get_env("DISABLE_SERVER"), do: false, else: true
  end
end
