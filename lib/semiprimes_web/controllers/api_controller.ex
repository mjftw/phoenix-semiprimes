defmodule SemiprimesWeb.APIController do
  use SemiprimesWeb, :controller
  alias Semiprimes.Math

  # ===== Route handling actions ======

  def semiprime(conn, args) do
    case validate_args(args) do
      {:error, error}
        -> conn
        |> put_status(:bad_request)
        |> json(%{"error" => error})
      {:ok, _}
        -> semiprime_response(conn, args)
    end
  end

# ===== Private helper functions ======
  # Single number to check if semiprime
  defp semiprime_response(conn, %{"number" => number}) do
    json(conn, semiprime_answer(number))
  end

  # Batch of numbers to check if semiprime
  defp semiprime_response(conn, %{"batch" => batch}) do
    json(conn, %{
      "batch" => Enum.map(batch, &semiprime_answer/1)
    })
  end

  # Helper to ensure consistent return format
  defp semiprime_answer(num) do
    %{
      "number" => num,
      "is_semiprime" => Math.is_semiprime?(num)
    }
  end

  defp validate_args(args) do
    cond do
      not (Map.has_key?(args, "number") or Map.has_key?(args, "batch")) ->
        {:error, "request must contain 'number' or 'batch' arguments"}

      Map.has_key?(args, "number") and not is_natural_number?(args["number"]) ->
        {:error, "number argument must be a positive integer"}

      Map.has_key?(args, "batch") and not is_list(args["batch"]) ->
        {:error, "batch arguement must be a list"}

      Map.has_key?(args, "batch") and not all_natural_numbers?(args["batch"]) ->
        {:error, "All batch elements must be positive integers"}

      true ->
        {:ok, ""}
    end
  end

  defp is_natural_number?(number) do
    is_integer(number) and number > 0
  end

  defp all_natural_numbers?(numbers) do
    numbers
    |> Enum.map(&is_natural_number?/1)
    |> Enum.all?()
  end

end
