defmodule ScsWeb.Router do
  use ScsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ScsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScsWeb do
    pipe_through :browser

    get "/", PageController, :home
    live("/scs", MainLive.Index, :index)
    live("/scs/admission", AdmissionLive.Index, :index)
    live("/scs/about", AboutLive.Index, :index)
    live("/scs/academic", AcademicLive.Index, :index)
    live("/scs/del", DelLive.Index, :index)
    live("/scs/athletics", AthleticsLive.Index, :index)
    live("/scs/arts", ArtsLive.Index, :index)
    live("/scs/giving", GivingLive.Index, :index)
    live("/scs/etc", EtcLive.Index, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:scs, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ScsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
