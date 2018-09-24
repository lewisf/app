defmodule AppWeb.Accounts.UserResolver do
  alias App.Accounts.User
  alias App.Repo

  def create_user_with_email_and_password(params, _info) do
    AppWeb.AuthHelper.create_user(params)
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- AppWeb.AuthHelper.login_with_email_and_password(email, password),
         {:ok, jwt, _} <- AppWeb.Guardian.encode_and_sign(user),
         {:ok, _} <- AppWeb.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end
end

defmodule AppWeb.AuthHelper do
  @moduledoc false

  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias App.Repo
  alias App.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def login_with_email_and_password(email, given_password) do
    user = Repo.get_by(User, email: String.downcase(email))

    cond do
      user && checkpw(given_password, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, :"User not found"}
    end
  end
end
