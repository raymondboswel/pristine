defmodule UiWeb.DustValueLiveTest do
  use UiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ui.DataFixtures

  @create_attrs %{value: 120.5}
  @update_attrs %{value: 456.7}
  @invalid_attrs %{value: nil}

  defp create_dust_value(_) do
    dust_value = dust_value_fixture()
    %{dust_value: dust_value}
  end

  describe "Index" do
    setup [:create_dust_value]

    test "lists all dust_values", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.dust_value_index_path(conn, :index))

      assert html =~ "Listing Dust values"
    end

    test "saves new dust_value", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.dust_value_index_path(conn, :index))

      assert index_live |> element("a", "New Dust value") |> render_click() =~
               "New Dust value"

      assert_patch(index_live, Routes.dust_value_index_path(conn, :new))

      assert index_live
             |> form("#dust_value-form", dust_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dust_value-form", dust_value: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dust_value_index_path(conn, :index))

      assert html =~ "Dust value created successfully"
    end

    test "updates dust_value in listing", %{conn: conn, dust_value: dust_value} do
      {:ok, index_live, _html} = live(conn, Routes.dust_value_index_path(conn, :index))

      assert index_live |> element("#dust_value-#{dust_value.id} a", "Edit") |> render_click() =~
               "Edit Dust value"

      assert_patch(index_live, Routes.dust_value_index_path(conn, :edit, dust_value))

      assert index_live
             |> form("#dust_value-form", dust_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dust_value-form", dust_value: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dust_value_index_path(conn, :index))

      assert html =~ "Dust value updated successfully"
    end

    test "deletes dust_value in listing", %{conn: conn, dust_value: dust_value} do
      {:ok, index_live, _html} = live(conn, Routes.dust_value_index_path(conn, :index))

      assert index_live |> element("#dust_value-#{dust_value.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#dust_value-#{dust_value.id}")
    end
  end

  describe "Show" do
    setup [:create_dust_value]

    test "displays dust_value", %{conn: conn, dust_value: dust_value} do
      {:ok, _show_live, html} = live(conn, Routes.dust_value_show_path(conn, :show, dust_value))

      assert html =~ "Show Dust value"
    end

    test "updates dust_value within modal", %{conn: conn, dust_value: dust_value} do
      {:ok, show_live, _html} = live(conn, Routes.dust_value_show_path(conn, :show, dust_value))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dust value"

      assert_patch(show_live, Routes.dust_value_show_path(conn, :edit, dust_value))

      assert show_live
             |> form("#dust_value-form", dust_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#dust_value-form", dust_value: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dust_value_show_path(conn, :show, dust_value))

      assert html =~ "Dust value updated successfully"
    end
  end
end
