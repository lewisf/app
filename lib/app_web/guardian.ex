defmodule AppWeb.Guardian do
  use Guardian, otp_app: :app
  alias AppWeb.Accounts

  @spec subject_for_token(%App.Accounts.User{}, any()) :: {:ok, String.t}
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  @spec resource_from_claims(%{sub: String.t}) :: {:ok, %App.Accounts.User{}}
  def resource_from_claims(claims) do
    user = claims["sub"] |> Accounts.get_user!
    {:ok, user}
  end
end
