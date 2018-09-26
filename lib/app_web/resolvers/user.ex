defmodule AppWeb.Resolvers.User do
  alias App.Accounts.User
  alias App.Repo

  def create_user_with_email_and_password(%{email: email, password: password}, _info) do
    User.Authentication.create_user_with_email_and_password(email, password)
  end

  def authenticate_with_sms(%{phone_number: phone_number, sms_code: sms_code}, _info) do
  end

  def authenticate_with_email_and_password(%{email: email, password: password}, _info) do
    with {:ok, user} <- User.Authentication.login_with_email_and_password(email, password),
         {:ok, jwt, _} <- AppWeb.Guardian.encode_and_sign(user),
         {:ok, refresh_jwt, _ } <- AppWeb.Guardian.encode_and_sign(user, "refresh"),
         {:ok, _} <- User.Authentication.store_token(user, jwt, refresh_jwt) do
      {:ok, %{token: jwt, refresh_token: refresh_jwt}}
    else
      {:error, error} -> {:error, error}
    end
  end

  def authenticate_with_refresh_token(%{refresh_token: refresh_token}, _info) do
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end
end
