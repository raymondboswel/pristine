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

  describe "dust_values" do
    alias Ui.Data.DustValue

    import Ui.DataFixtures

    @invalid_attrs %{value: nil}

    test "list_dust_values/0 returns all dust_values" do
      dust_value = dust_value_fixture()
      assert Data.list_dust_values() == [dust_value]
    end

    test "get_dust_value!/1 returns the dust_value with given id" do
      dust_value = dust_value_fixture()
      assert Data.get_dust_value!(dust_value.id) == dust_value
    end

    test "create_dust_value/1 with valid data creates a dust_value" do
      valid_attrs = %{value: 120.5}

      assert {:ok, %DustValue{} = dust_value} = Data.create_dust_value(valid_attrs)
      assert dust_value.value == 120.5
    end

    test "create_dust_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_dust_value(@invalid_attrs)
    end

    test "update_dust_value/2 with valid data updates the dust_value" do
      dust_value = dust_value_fixture()
      update_attrs = %{value: 456.7}

      assert {:ok, %DustValue{} = dust_value} = Data.update_dust_value(dust_value, update_attrs)
      assert dust_value.value == 456.7
    end

    test "update_dust_value/2 with invalid data returns error changeset" do
      dust_value = dust_value_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_dust_value(dust_value, @invalid_attrs)
      assert dust_value == Data.get_dust_value!(dust_value.id)
    end

    test "delete_dust_value/1 deletes the dust_value" do
      dust_value = dust_value_fixture()
      assert {:ok, %DustValue{}} = Data.delete_dust_value(dust_value)
      assert_raise Ecto.NoResultsError, fn -> Data.get_dust_value!(dust_value.id) end
    end

    test "change_dust_value/1 returns a dust_value changeset" do
      dust_value = dust_value_fixture()
      assert %Ecto.Changeset{} = Data.change_dust_value(dust_value)
    end
  end
end
