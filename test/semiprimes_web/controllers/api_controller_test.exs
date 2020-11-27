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

  test "POST to :semiprime action returns is_semiprime same as Math.is_semiprime?/1", %{conn: conn} do
    number = 101
    resp = post(conn, Routes.api_v1_api_path(conn, :semiprime), number: number)

    expected = Semiprimes.Math.is_semiprime?(number)
    assert %{"number" => ^number, "is_semiprime" => ^expected} = json_response(resp, 200)
  end
end
