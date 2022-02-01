defmodule Ui.DataTest do
  use Ui.DataCase

  alias Ui.Data

  describe "temps" do
    alias Ui.Data.Temp

    import Ui.DataFixtures

    @invalid_attrs %{value: nil}

    test "list_temps/0 returns all temps" do
      temp = temp_fixture()
      assert Data.list_temps() == [temp]
    end

    test "get_temp!/1 returns the temp with given id" do
      temp = temp_fixture()
      assert Data.get_temp!(temp.id) == temp
    end

    test "create_temp/1 with valid data creates a temp" do
      valid_attrs = %{value: 120.5}

      assert {:ok, %Temp{} = temp} = Data.create_temp(valid_attrs)
      assert temp.value == 120.5
    end

    test "create_temp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_temp(@invalid_attrs)
    end

    test "update_temp/2 with valid data updates the temp" do
      temp = temp_fixture()
      update_attrs = %{value: 456.7}

      assert {:ok, %Temp{} = temp} = Data.update_temp(temp, update_attrs)
      assert temp.value == 456.7
    end

    test "update_temp/2 with invalid data returns error changeset" do
      temp = temp_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_temp(temp, @invalid_attrs)
      assert temp == Data.get_temp!(temp.id)
    end

    test "delete_temp/1 deletes the temp" do
      temp = temp_fixture()
      assert {:ok, %Temp{}} = Data.delete_temp(temp)
      assert_raise Ecto.NoResultsError, fn -> Data.get_temp!(temp.id) end
    end

    test "change_temp/1 returns a temp changeset" do
      temp = temp_fixture()
      assert %Ecto.Changeset{} = Data.change_temp(temp)
    end
  end
end
