defmodule Scs.Repo do
  use Ecto.Repo,
    otp_app: :scs,
    adapter: Ecto.Adapters.Postgres
end
