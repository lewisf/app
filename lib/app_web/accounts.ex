defmodule AppWeb.Accounts do
  alias App.Accounts.User
  alias App.Repo

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get! User, id
  end

  def store_token(%User{} =user, token) do
    user
    |> User.store_token_changeset(%{token: token})
    |> Repo.update()
  end
end
