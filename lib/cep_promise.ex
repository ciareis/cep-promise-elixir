defmodule CepPromise do
  @moduledoc """
  Consulta CEP `CepPromise`.
  """

  @doc """
  info

  ## Examples

      iex> CepPromise.info("80020100")
      {:ok,
        %CepPromise.Cep{
          cep: "80020100",
          city: "Curitiba",
          neighborhood: "Centro",
          state: "PR",
          street: "Praça Tiradentes"
          }
      }

      iex> CepPromise.info("00000000")
      {:error, "CEP not found."}

      iex> CepPromise.info("123")
      {:error, "CEP Invalid."}

  """
  alias CepPromise.Providers.BrasilApi
  alias CepPromise.Providers.ViaCep

  def info(cep) do
    case parse_cep(cep) do
      {:error, _} = error -> error
      value -> search(value)
    end
  end

  defp parse_cep(cep) do
    cep =
      cep
      |> String.replace("-", "")
      |> String.replace(".", "")

    case Regex.run(~r/[0-9]+/s, cep) do
      nil -> {:error, "Cep inválido"}
      [value | _] -> value
    end
  end

  defp search(cep) when byte_size(cep) == 8 do
    tasks = [
      Task.async(fn -> BrasilApi.info(cep) end),
      Task.async(fn -> ViaCep.info(cep) end)
    ]

    cep = await(tasks)

    Enum.map(tasks, fn task -> Task.shutdown(task) end)
    cep
  end

  defp search(_), do: {:error, "CEP Invalid."}

  defp await(tasks) when is_list(tasks) and length(tasks) > 0 do
    # IO.inspect(tasks, label: "TASKS")

    receive do
      {_reply, {:ok, cep}} ->
        {:ok, cep}

      nil ->
        await(tasks)

      {reply, {:error, _}} ->
        filter_tasks(tasks, reply)

      [] ->
        {:error, "CEP not found."}
    end
  end

  defp await(_), do: {:error, "CEP not found."}

  defp filter_tasks(tasks, reply) do
    Enum.filter(tasks, fn %Task{ref: ref} -> reply != ref end)
    |> await()
  end

  # defp filter_tasks(%Task{ref: ref} = _task, reply, acc) when ref == reply, do: acc

  # defp filter_tasks(%Task{ref: ref} = task, reply, _acc) when ref != reply, do: task
end
