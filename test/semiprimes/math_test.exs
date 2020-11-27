defmodule MathTest do
  use ExUnit.Case
  import Semiprimes.Math
  doctest(Semiprimes.Math)

  # Most the tests are doctests as these give the bonus of providing a documented API.
  test "is_semiprime?/1 returns true for larger numbers known to be semiprimes" do
    assert is_semiprime?(3595)
  end

  test "is_semiprime?/1 returns false for larger known not to be semiprimes" do
    assert is_semiprime?(4000) == false
  end
end
