defmodule Appp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Pbkdf2, only: [hash_pwd_salt: 1]

  schema "users" do
    field :age, :integer
    field :email, :string
    field :password_hash_one, :string
    field :password_hash_two, :string
    field :username, :string
    field :password_one, :string, virtual: true
    field :password_two, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :age, :email, :password_hash_one, :password_hash_two])
    |> validate_required([:username, :age, :email, :password_hash_one, :password_hash_two])
    |> unique_constraint(:email)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :age, :email, :password_one, :password_two])
    |> validate_required([:username, :email, :password_one, :password_two])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_one, min: 3)
    |> validate_length(:password_two, min: 3)
    |> put_password_hash
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_one: pass_one, password_two: pass_two}} ->
        changeset
        |> put_change(:password_hash_one, hash_pwd_salt(pass_one))
        |> put_change(:password_hash_two, hash_pwd_salt(pass_two))

      _ ->
        changeset
    end
  end
end
