defmodule SemiprimesWeb.APIController do
  use SemiprimesWeb, :controller
  alias Semiprimes.Math

  # Single number to check if semiprime
  def semiprime(conn, %{"number" => number}) do
    json(conn, semiprime_answer(number))
  end

  # Batch of numbers to check if semiprime
  def semiprime(conn, %{"batch" => batch}) do
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
end
