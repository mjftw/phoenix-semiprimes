defmodule SemiprimesWeb.APIControllerTest do
  use SemiprimesWeb.ConnCase

  test "POST to :semiprime action, correct response structure", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), number: 3)
    assert %{"number" => _, "is_semiprime" => _} = json_response(resp, 200)
  end

  test "POST to :semiprime action returns number sent", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), number: 3)
    assert %{"number" => 3, "is_semiprime" => _} = json_response(resp, 200)
  end

  test "POST to :semiprime action returns 400 on invalid number format", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), number: "hello")
    assert json_response(resp, 400)
  end

  test "POST to :semiprime action returns 400 on missing number or batch arg", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime))
    assert json_response(resp, 400)
  end

  test "POST to :semiprime action returns 400 on batch not all numbers", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), batch: [1, "hello", 3])
    assert json_response(resp, 400)
  end

  test "POST to :semiprime action returns 400 on batch not list", %{conn: conn} do
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), batch: "foo")
    assert json_response(resp, 400)
  end

  test "POST to :semiprime action returns is_semiprime same as Math.is_semiprime?/1", %{conn: conn} do
    number = 101
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), number: number)

    # Only checking answer is expected not correct, Math.is_semiprime?/1 has its own tests
    expected = Semiprimes.Math.is_semiprime?(number)
    assert %{"number" => ^number, "is_semiprime" => ^expected} = json_response(resp, 200)
  end

  test "POST to :semiprime action, correct response format with a batch of numbers", %{conn: conn} do
    numbers = [9, 10, 11]
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), batch: numbers)

    # Check batch in response, and batch is non-empty list
    assert %{"batch" => [_ | _] } = json_response(resp, 200)
  end

  test "POST to :semiprime action works with a batch of numbers", %{conn: conn} do
    numbers = [9, 10, 11, 15, 19, 21, 35]

    # Only checking answer is expected not correct, Math.is_semiprime?/1 has its own tests
    expected_is_semiprimes = Enum.map(numbers, &Semiprimes.Math.is_semiprime?/1)
    expected_items =
      for {number, is_semiprime} <- Enum.zip(numbers, expected_is_semiprimes) do
        %{"number" => number, "is_semiprime" => is_semiprime}
      end
    expected = %{"batch" => expected_items}

    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), batch: numbers)

    assert expected == json_response(resp, 200)
  end

end
