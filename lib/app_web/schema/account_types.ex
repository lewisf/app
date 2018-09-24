defmodule AppWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  object :session do
    field :token, non_null(:string)
  end
end
