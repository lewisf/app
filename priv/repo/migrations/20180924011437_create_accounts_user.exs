defmodule App.Repo.Migrations.CreateAccountsUser do
  use Ecto.Migration

  def change do
    create table(:accounts_user) do
      add :email, :string
      add :password, :string
      add :password_hash, :string
      add :token, :string

      timestamps()
    end

  end
end
