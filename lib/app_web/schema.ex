defmodule AppWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types AppWeb.Schema.AccountTypes

  # @fakedb %{
  #   "1" => %{name: "Bob", email: "bubba@foo.com"},
  #   "2" => %{name: "Fred", email: "fredmeister@foo.com"},
  # }

  query do
    field :profile, :user do
      resolve fn _, %{context: %{current_user: current_user}} ->
        {:ok, Map.get(@fakedb, current_user.id)}
      end
    end
  end

  mutation do
    @desc "User signup with email and password"
    field :create_user_with_email_and_password, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :username, :string

      resolve &AppWeb.Accounts.UserResolver.create_user_with_email_and_password/2
    end

    @desc "User login via JWT"
    field :login_with_email_and_password, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &AppWeb.Accounts.UserResolver.login/2
    end
  end

end
