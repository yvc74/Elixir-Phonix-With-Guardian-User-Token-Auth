defmodule ApppWeb.FakeControllerTest do
  use ApppWeb.ConnCase

  alias Appp.JustFake

  @create_attrs %{age: 42, name: "some name"}
  @update_attrs %{age: 43, name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  def fixture(:fake) do
    {:ok, fake} = JustFake.create_fake(@create_attrs)
    fake
  end

  describe "index" do
    test "lists all fakes", %{conn: conn} do
      conn = get(conn, Routes.fake_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fakes"
    end
  end

  describe "new fake" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fake_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fake"
    end
  end

  describe "create fake" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fake_path(conn, :create), fake: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fake_path(conn, :show, id)

      conn = get(conn, Routes.fake_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fake"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fake_path(conn, :create), fake: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fake"
    end
  end

  describe "edit fake" do
    setup [:create_fake]

    test "renders form for editing chosen fake", %{conn: conn, fake: fake} do
      conn = get(conn, Routes.fake_path(conn, :edit, fake))
      assert html_response(conn, 200) =~ "Edit Fake"
    end
  end

  describe "update fake" do
    setup [:create_fake]

    test "redirects when data is valid", %{conn: conn, fake: fake} do
      conn = put(conn, Routes.fake_path(conn, :update, fake), fake: @update_attrs)
      assert redirected_to(conn) == Routes.fake_path(conn, :show, fake)

      conn = get(conn, Routes.fake_path(conn, :show, fake))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, fake: fake} do
      conn = put(conn, Routes.fake_path(conn, :update, fake), fake: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fake"
    end
  end

  describe "delete fake" do
    setup [:create_fake]

    test "deletes chosen fake", %{conn: conn, fake: fake} do
      conn = delete(conn, Routes.fake_path(conn, :delete, fake))
      assert redirected_to(conn) == Routes.fake_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.fake_path(conn, :show, fake))
      end
    end
  end

  defp create_fake(_) do
    fake = fixture(:fake)
    {:ok, fake: fake}
  end
end
