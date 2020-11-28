defmodule SemiprimesWeb.APIController do
  use SemiprimesWeb, :controller
  alias SemiprimesWeb.APIController.SemiprimeParams
  alias Semiprimes.Math

  # ===== Route handling actions ======
    def semiprime(conn, args) do
    changeset = SemiprimeParams.changeset(args)

    case changeset.valid? do
      true ->
        semiprime_response(conn, args)

      false ->
        conn
        |> put_status(:bad_request)
        |> json(%{"error" => SemiprimeParams.errors(changeset)})
    end
  end

  # ===== Params validation =====
  # Note: While using Ecto for parameter validation results in more code in this case, it is
  #   a lot easier to expand in future, should more params with more validation be required.
  #   Ecto.Changeset also provides a lot of different validation options, preventing the need
  #   to implement many custom validation checkers.
  #
  # This module could easily have been moved to its own file, but since it only has relevance
  # to this Controller, it makes sense to keep it nested within.
  defmodule SemiprimeParams do
    import Ecto.Changeset

    @doc """
      Get an Ecto.Changeset for the given params, performing validation on them
    """
    def changeset(params) do
      types = %{number: :integer, batch: {:array, :integer}}

      {params, types}
      |> cast(params, Map.keys(types))
      |> validate_required_params(params)
    end

    @doc """
      Flatten the errors found by Ecto into a Map.
      Required in order to convert to JSON response as the Json.Encoder protocol
      is not implemented for tuples.
    """
    def errors(%{errors: errors}) do
      Enum.map(errors, &flatten_error/1)
    end

    defp flatten_error({err_atom, {message, _type}}) do
      %{Atom.to_string(err_atom) => message}
    end

    defp validate_required_params(changeset, %{"number" => _}) do
      changeset
      |> validate_number(:number, greater_than: 0)
    end

    defp validate_required_params(changeset, %{"batch" => _}) do
      changeset
      |> validate_required(:batch)
    end

    defp validate_required_params(changeset, _params) do
      changeset
      |> add_error(:number, "request must contain 'number' or 'batch' arguments")
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
end
