defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "sad673d"
    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "sad673d",
             user: %Rockelivery.User{
               address: "Av Salvador",
               age: 25,
               cep: "95775000",
               cpf: "02227869045",
               email: "wilson@gmail.com",
               id: "333a2744-e1b6-4563-a787-76e897a59da1",
               inserted_at: nil,
               name: "Wilson",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } == response
  end
end
