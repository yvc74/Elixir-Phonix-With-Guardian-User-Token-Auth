defmodule Appp.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Appp.Repo

  alias Appp.Accounts.User
  import Pbkdf2, only: [verify_pass: 2, no_user_verify: 0]

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def user_auth(%{"email" => email, "password" => password}) do
    with {:ok, user} <- get_user_by_email(email),
         {:ok, user} <- match_password(user, password) do
      {:ok, user}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def user_auth(%{"username" => username, "password" => password}) do
    with {:ok, user} <- get_user_by_username(username),
         {:ok, user} <- match_password(user, password) do
      {:ok, user}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  defp get_user_by_email(email) do
    with %User{} = user <- Repo.get_by(User, email: email) do
      {:ok, user}
    else
      _nil ->
        no_user_verify()
        message = "Email Not Found"
        {:error, message}
    end
  end

  defp get_user_by_username(username) do
    with %User{} = user <- Repo.get_by(User, username: username) do
      {:ok, user}
    else
      _nil ->
        no_user_verify()
        message = "Username Not Found"
        {:error, message}
    end
  end

  defp match_password(%User{} = user, password) do
    if verify_pass(password, user.password_hash_one) do
      {:ok, user}
    else
      message = "invalid password"
      {:error, message}
    end
  end
end
