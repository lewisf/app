defmodule AppWeb.Schema do
  use Absinthe.Schema

  @fakedb %{
    "1" => %{name: "Bob", email: "bubba@foo.com"},
    "2" => %{name: "Fred", email: "fredmeister@foo.com"},
  }

  query do
    field :profile, :user do
      resolve fn _, %{context: %{current_user: current_user}} ->
        {:ok, Map.get(@fakedb, current_user.id)}
      end
    end
  end

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

end
