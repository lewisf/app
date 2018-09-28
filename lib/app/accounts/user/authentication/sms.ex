defmodule App.Accounts.User.Authentication.Sms do
  import Ecto.Query, only: [where: 2]
  alias App.Repo
  alias App.Accounts.User

  def authenticate_by_phone_number(phone_number) do
    existing_user = User
      |> where(phone_number: ^phone_number)
      |> Repo.one()

    # TODO: Determine difference between claimed phone number
    # account and non claimed phone number account
    case existing_user do
      nil -> record_create_account_claim(phone_number)
      user -> record_login_claim(phone_number)
    end
  end

  defp record_create_account_claim(phone_number) do
  end

  defp record_login_claim(phone_number) do
  end
end
