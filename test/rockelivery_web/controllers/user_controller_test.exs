defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true
  use RockeliveryWeb, :controller

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 25,
        "address" => "Av Salvador",
        "cep" => "95775000",
        "cpf" => "02227869045",
        "email" => "wilson@gmail.com",
        "password" => "123456",
        "name" => "Wilson"
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Av Salvador",
                 "age" => 25,
                 "cpf" => "02227869045",
                 "email" => "wilson@gmail.com",
                 "id" => _id,
                 "name" => "Wilson"
               }
             } = response
    end

    test "when there is some error, returns the errorr", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Wilson"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expedted_response = %{
        "mesage" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert expedted_response == response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "333a2744-e1b6-4563-a787-76e897a59da1"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert "" == response
    end
  end
end
