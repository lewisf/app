defmodule AppWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias AppWeb.Resolvers

  import_types AppWeb.Schema.AccountTypes
  import_types AppWeb.Schema.PostTypes

  node interface do
    resolve_type(fn
      %{token: _token}, _ -> :session
      %App.Accounts.User{}, _ -> :user
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :user, id: id}, _ ->
          id
          |> String.to_integer()
          |> Resolvers.User.get_by_id()
      end)
    end

    field :profile, :user do
      resolve(fn (_, context) ->
        case context do
          %{context: %{current_user: current_user}} -> {:ok, current_user}
          _ -> {:ok, %{ name: "Guest" }}
        end
      end)
    end
  end

  mutation do
    @desc "User signup with email and password"
    field :create_user_with_email_and_password, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :username, :string

      resolve &AppWeb.Resolvers.User.create_user_with_email_and_password/2
    end

    @desc "User login via JWT"
    field :login_with_email_and_password, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &AppWeb.Resolvers.User.login/2
    end
  end

end
