defmodule UiWeb.TempLiveTest do
  use UiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ui.DataFixtures

  @create_attrs %{value: 120.5}
  @update_attrs %{value: 456.7}
  @invalid_attrs %{value: nil}

  defp create_temp(_) do
    temp = temp_fixture()
    %{temp: temp}
  end

  describe "Index" do
    setup [:create_temp]

    test "lists all temps", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.temp_index_path(conn, :index))

      assert html =~ "Listing Temps"
    end

    test "saves new temp", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.temp_index_path(conn, :index))

      assert index_live |> element("a", "New Temp") |> render_click() =~
               "New Temp"

      assert_patch(index_live, Routes.temp_index_path(conn, :new))

      assert index_live
             |> form("#temp-form", temp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#temp-form", temp: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.temp_index_path(conn, :index))

      assert html =~ "Temp created successfully"
    end

    test "updates temp in listing", %{conn: conn, temp: temp} do
      {:ok, index_live, _html} = live(conn, Routes.temp_index_path(conn, :index))

      assert index_live |> element("#temp-#{temp.id} a", "Edit") |> render_click() =~
               "Edit Temp"

      assert_patch(index_live, Routes.temp_index_path(conn, :edit, temp))

      assert index_live
             |> form("#temp-form", temp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#temp-form", temp: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.temp_index_path(conn, :index))

      assert html =~ "Temp updated successfully"
    end

    test "deletes temp in listing", %{conn: conn, temp: temp} do
      {:ok, index_live, _html} = live(conn, Routes.temp_index_path(conn, :index))

      assert index_live |> element("#temp-#{temp.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#temp-#{temp.id}")
    end
  end

  describe "Show" do
    setup [:create_temp]

    test "displays temp", %{conn: conn, temp: temp} do
      {:ok, _show_live, html} = live(conn, Routes.temp_show_path(conn, :show, temp))

      assert html =~ "Show Temp"
    end

    test "updates temp within modal", %{conn: conn, temp: temp} do
      {:ok, show_live, _html} = live(conn, Routes.temp_show_path(conn, :show, temp))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Temp"

      assert_patch(show_live, Routes.temp_show_path(conn, :edit, temp))

      assert show_live
             |> form("#temp-form", temp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#temp-form", temp: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.temp_show_path(conn, :show, temp))

      assert html =~ "Temp updated successfully"
    end
  end
end
