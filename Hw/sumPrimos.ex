# Actividad 5.2 Programacion paralela y concurrente
#
# Ivan Diaz Lara A01365801
# Octavio Fenollosa A01781042
# 2022-06-27
#

defmodule Primes do
@moduledoc """
Obtain the sum of all prime numbers from 0 to n
"""
@doc """
Analyze the given number to determine whether it is or it is not
a prime number
"""
  # As 2 is the first prime number, there is no point in analyzing 1 and 0
  def is_prime(num) when num < 2, do: false
  def is_prime(num), do: do_is_prime(num, 2)

  defp do_is_prime(num, i) do
    cond do
      # Num will be prime when it is not divisible by any
      # number that is smaller than the prime's number square root.
      floor(:math.sqrt(num)) < i -> true
      #Reminder is equal to 0
      rem(num, i) == 0 -> false
      # Recursive step when the remainder is not equal to 0
      rem(num, i) != 0 -> do_is_prime(num, i + 1)
    end
  end

  @doc """
  Obtain the secuencial sum fo the prime numbers rom 0 to n
  """
  def sum_primes(0), do: 0
  def sum_primes(lim) do
    do_sum_primes(2, lim, 0)
  end

  defp do_sum_primes(start, finish, res) when start > finish, do: res
  defp do_sum_primes(start, finish, res) do
    cond do
    (is_prime(start) == true) ->
      # Add the prime number to the result
      do_sum_primes(start + 1, finish, res + start)
    (is_prime(start) == false) ->
      # Skip the non-prime number
      do_sum_primes(start + 1, finish, res)
    end
  end

  @doc """
  Obtain the sum of the prime numbers from 0 to n using parallelism
  """
  def sum_primes_parallel(lim, workers \\ System.schedulers) do
    range = div(lim, workers)

   1..workers
    |> Enum.map(&Task.async(fn-> do_sum_primes((&1 * range) - range + 1, &1 * range, 0) end))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
  end

  @doc """
  Obtain the sum of the prime numbers found within a minimum range
  to a maximum range using parallelism.
  """
  def sum_primes_range(0), do: 0
  def sum_primes_range(min, max) do
    do_sum_primes(min, max, 0)
  end

  @doc """
  Obtain the time the specified function took to finish executing

  Call from the iex:
  Primes.time(fn -> Primes.(<function>) end)
  """
  def timer(func) do
    func
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
