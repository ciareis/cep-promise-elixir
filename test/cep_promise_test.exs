defmodule CepPromiseTest do
  use ExUnit.Case
  doctest CepPromise

  describe "teste una exame" do
    test "outra exemplo" do
      response = CepPromise.info("80020100")

      assert response ==
               {:ok,
                %CepPromise.Cep{
                  cep: "80020100",
                  city: "Curitiba",
                  neighborhood: "Centro",
                  state: "PR",
                  street: "Praça Tiradentes"
                }}
    end
  end
end
