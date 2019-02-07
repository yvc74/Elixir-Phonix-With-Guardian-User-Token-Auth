defmodule Digitaldrawer.JustFakeTest do
  use Digitaldrawer.DataCase

  alias Digitaldrawer.JustFake

  describe "fakes" do
    alias Digitaldrawer.JustFake.Fake

    @valid_attrs %{age: 42, name: "some name"}
    @update_attrs %{age: 43, name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def fake_fixture(attrs \\ %{}) do
      {:ok, fake} =
        attrs
        |> Enum.into(@valid_attrs)
        |> JustFake.create_fake()

      fake
    end

    test "list_fakes/0 returns all fakes" do
      fake = fake_fixture()
      assert JustFake.list_fakes() == [fake]
    end

    test "get_fake!/1 returns the fake with given id" do
      fake = fake_fixture()
      assert JustFake.get_fake!(fake.id) == fake
    end

    test "create_fake/1 with valid data creates a fake" do
      assert {:ok, %Fake{} = fake} = JustFake.create_fake(@valid_attrs)
      assert fake.age == 42
      assert fake.name == "some name"
    end

    test "create_fake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JustFake.create_fake(@invalid_attrs)
    end

    test "update_fake/2 with valid data updates the fake" do
      fake = fake_fixture()
      assert {:ok, %Fake{} = fake} = JustFake.update_fake(fake, @update_attrs)
      assert fake.age == 43
      assert fake.name == "some updated name"
    end

    test "update_fake/2 with invalid data returns error changeset" do
      fake = fake_fixture()
      assert {:error, %Ecto.Changeset{}} = JustFake.update_fake(fake, @invalid_attrs)
      assert fake == JustFake.get_fake!(fake.id)
    end

    test "delete_fake/1 deletes the fake" do
      fake = fake_fixture()
      assert {:ok, %Fake{}} = JustFake.delete_fake(fake)
      assert_raise Ecto.NoResultsError, fn -> JustFake.get_fake!(fake.id) end
    end

    test "change_fake/1 returns a fake changeset" do
      fake = fake_fixture()
      assert %Ecto.Changeset{} = JustFake.change_fake(fake)
    end
  end
end
