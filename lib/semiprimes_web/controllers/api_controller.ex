defmodule SemiprimesWeb.APIController do
  use SemiprimesWeb, :controller
  alias Semiprimes.Math

  def semiprime(conn, %{"number" => number}) do
    json(conn, %{
      "number" => number,
      "is_semiprime" => Math.is_semiprime?(number)
    })
  end
end
