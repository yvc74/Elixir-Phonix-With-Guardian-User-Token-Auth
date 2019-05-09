defmodule Appp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :age, :integer
      add :email, :string
      add :password_hash_one, :string
      add :password_hash_two, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
