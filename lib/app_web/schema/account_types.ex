defmodule AppWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object :user do
    field :name, :string
    field :email, :string
  end

  node object :session do
    field :token, non_null(:string)
  end
end
