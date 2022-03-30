defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all param are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(%User{}, params)

      assert %Changeset{changes: %{name: "Wilson"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the givem changes" do
      params = build(:user_params)

      update_params = %{name: "Vilson", password: "123456"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Vilson"}, valid?: true} = response
    end

    test "when there are soma error, returns an invalid changeset" do
      params = build(:user_params, %{"age" => 15, "password" => "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
