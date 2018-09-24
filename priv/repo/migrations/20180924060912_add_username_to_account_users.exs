defmodule App.Repo.Migrations.AddUsernameToAccountUsers do
  use Ecto.Migration

  def change do
    alter table(:accounts_user) do
      add :username, :string
    end
  end
end
