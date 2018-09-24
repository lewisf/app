defmodule App.Accounts.UserTest do
  use App.DataCase

  alias App.Accounts.User

  @valid_attrs %{email: "pat@example.com", password: "some_password"}
  @invalid_attrs %{}

  test "changeset" do
    changeset = User.changeset(%User{}, @valid_attrs)

    assert changeset.valid?
    assert nil != changeset.changes.password_hash
  end

  test "store_token_changeset" do
    user = struct(User, @valid_attrs)
    changeset = User.store_token_changeset(user, %{token: "asdf"});
    assert changeset.changes.token == "asdf"
  end
end
