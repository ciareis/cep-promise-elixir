defmodule CepPromise.Providers.ViaCep do
  @moduledoc false
  alias CepPromise.Cep
  use Tesla
  alias Tesla.Env

  plug(Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/")
  plug(Tesla.Middleware.JSON)

  def info(cep) do
    "#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => true}}}) do
    {:error, "CEP not found"}
  end

  defp handle_get({:ok, %Env{status: 400}}) do
    {:error, "Invalid CEP"}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}), do: build_cep(body)

  defp build_cep(%{
         "cep" => cep,
         "logradouro" => street,
         "bairro" => neighborhood,
         "uf" => state,
         "localidade" => city
       }) do
    {:ok, Cep.build(cep, state, city, street, neighborhood, "ViaCep")}
  end
end
