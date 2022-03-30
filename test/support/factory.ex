defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 25,
      "address" => "Av Salvador",
      "cep" => "95775000",
      "cpf" => "02227869045",
      "email" => "wilson@gmail.com",
      "password" => "123456",
      "name" => "Wilson"
    }
  end

  def user_factory do
    %User{
      age: 25,
      address: "Av Salvador",
      cep: "95775000",
      cpf: "02227869045",
      email: "wilson@gmail.com",
      password: "123456",
      name: "Wilson",
      id: "333a2744-e1b6-4563-a787-76e897a59da1"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
