defmodule CepPromise.Cep do
  @moduledoc false
  # @moduledoc """
  # Documentation for `CepPromise.Cep`.
  # """
  #
  # @doc """
  # build
  #
  # ## Examples
  #
  #     iex> CepPromise.Cep.build("80020100", "PR", "Curitiba", "Praça Tiradentes", "Centro", "Service")
  #     %CepPromise.Cep{
  #       cep: "80020100",
  #       city: "Curitiba",
  #       neighborhood: "Centro",
  #       state: "PR",
  #       street: "Praça Tiradentes"
  #     }
  # """
  @keys [:cep, :street, :neighborhood, :city, :state]

  @enforce_keys @keys

  defstruct @keys ++ [:service]

  def build(cep, state, city, street, neighborhood, _service) do
    %__MODULE__{
      cep: parse_cep(cep),
      street: street,
      neighborhood: neighborhood,
      city: city,
      state: state
      # service: service
    }
  end

  defp parse_cep(cep) do
    cep
    |> String.replace("-", "")
    |> String.replace(".", "")
  end
end
