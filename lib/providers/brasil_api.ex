defmodule CepPromise.Providers.BrasilApi do
  @moduledoc false
  alias CepPromise.Cep
  @doc false
  use Tesla
  alias Tesla.Env

  plug(Tesla.Middleware.BaseUrl, "https://brasilapi.com.br/api/cep/v1/")
  plug(Tesla.Middleware.JSON)

  def info(cep) do
    "#{cep}"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404}}), do: {:error, "CEP not found"}

  defp handle_get({:ok, %Env{status: 400}}), do: {:error, "Invalid CEP"}

  defp handle_get({:ok, %Env{status: 200, body: body}}), do: build_cep(body)

  defp build_cep(%{
         "cep" => cep,
         "street" => street,
         "neighborhood" => neighborhood,
         "state" => state,
         "city" => city
       }) do
    {:ok, Cep.build(cep, state, city, street, neighborhood, "BrasilApi")}
  end
end
