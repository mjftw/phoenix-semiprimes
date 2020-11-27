defmodule Semiprimes.Math do
  @moduledoc """
    Maths functions around primes and semiprimes
  """

  @doc """
    Find whether a given number is semiprime.

    If a number has eactly 2 prime factors, then it is semiprime. 15 = 3*5,
    iex> is_semiprime?(15)
    true

    If a number is prime, then it is not semiprime
    iex> is_semiprime?(11)
    false

    If a number has 3 prime factors, then it is not semiprime. 16 = 2*2*2
    iex> is_semiprime?(16)
    false
  """
  @spec is_semiprime?(non_neg_integer) :: boolean
  def is_semiprime?(num) do
    prime_factors =
      for divisor <- 1..num,
          rem(num, divisor) == 0 and
            is_prime?(div(num, divisor)) and
            is_prime?(divisor),
          do: divisor

    length(prime_factors) == 2
  end

  @doc """
    Find whether a given number is prime.

    11 is divisible only by 1 and itself, so is therefore prime
    iex> is_prime?(11)
    true

    11 is divisible only by 1 and itself, so is therefore prime
    iex> is_prime?(11)
    true

    12 is divisible by 1, 2, 3, 4, 6, and 12, so is not prime
    iex> is_prime?(12)
    false
  """
  @spec is_prime?(non_neg_integer) :: boolean
  def is_prime?(num) do
    factors = for divisor <- 1..num, rem(num, divisor) == 0, do: divisor
    length(factors) == 2
  end
end
