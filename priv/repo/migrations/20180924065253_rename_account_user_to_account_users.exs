defmodule App.Repo.Migrations.RenameAccountUserToAccountUsers do
  use Ecto.Migration

  def up do
    rename table(:accounts_user), to: table(:accounts_users)
  end

  def down do
    rename table(:accounts_users), to: table(:accounts_user)
  end
end
