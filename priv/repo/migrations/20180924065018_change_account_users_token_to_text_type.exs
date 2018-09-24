defmodule App.Repo.Migrations.ChangeAccountUsersTokenToTextType do
  use Ecto.Migration

  def up do
    alter table(:accounts_user) do
      modify :token, :text
    end
  end

  def down do
    alter table(:accounts_user) do
      modify :token, :string
    end
  end
end
