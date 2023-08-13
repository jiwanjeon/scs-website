defmodule Scs.SCSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scs.SCS` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Scs.SCS.create_user()

    user
  end
end
