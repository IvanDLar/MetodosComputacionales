#Using parallelism to accelerate calculations using threads
#Ivan Diaz lara


defmodule Parallel do
  def pi_term(n), do: -1**(n + 1) * 4 / (2 * n - 1)

  def get_pi_seq(0), do: 0
  def get_pi_seq(limit), do: do_get_pi(1, limit, 0)

  defp do_get_pi(start, finish, res) when start > finish, do: res
  defp do_get_pi(start, finish, res),
    do: do_get_pi(start + 1, finish, res + pi_term(start))

  def get_pi_par(limit, workers \\ System.schedulers) do
    range = div(limit, workers)

    1..workers
    |> Enum.map(&Task.async(fn-> do_get_pi(1 + (&1 - 1) * range, &1 * range, 0) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()

    #Obtener lista con rangos y mapear la lista, pasarla a la funcion.
  end

end
