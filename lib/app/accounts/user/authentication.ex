defmodule App.Accounts.User.Authentication do
  import Comeonin.Bcrypt, only: [checkpw: 2]
  import Ecto.Query, only: [where: 2]
  alias App.Repo
  alias App.Accounts.User

  def create_user_with_email_and_password(email, password) do
    %User{}
    |> User.changeset(%{email: email, password: password})
    |> Repo.insert()
  end

  @spec login_with_email_and_password(binary(), any()) ::
          {:error, :"Incorrect login credentials" | :"User not found"}
          | {:ok, atom() | %{password_hash: binary()}}
  def login_with_email_and_password(email, given_password) do
    user = Repo.get_by(User, email: String.downcase(email))

    cond do
      user && checkpw(given_password, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :"Incorrect login credentials"}

      true ->
        {:error, :"User not found"}
    end
  end

  def store_token(%User{} = user, token, refresh_token) do
    user
    |> User.store_token_changeset(%{token: token, refresh_token: refresh_token})
    |> Repo.update()
  end
end
