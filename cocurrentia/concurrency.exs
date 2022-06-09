# Basics of concurrency in ELixir || multi-thread
#
#Iván Dïaz Lara
#2022-05-27

defmodule Concurr do

  def welcome(name)do
    IO.puts ("Hello #{name}")
  end

  def count(name, 0), do:  IO.puts("lift off!!")
  def count(name, n) do
    IO.puts("#{name}: #{n}")
    count(name, n-1)
  end

  def sum(n, limit) do
    Enum.sum(1..limit)
  end


  def main do
    IO.puts ("MAIN THREAD START")
    #Launch a thread, and don't wait for it to finish (Task.start)
    Task.start(fn->welcome("Gerardo") end)
    Task.start(fn->welcome("Pedro") end)
    Task.start(fn->welcome("Pepe") end)
    IO.puts("MAIN HTREAD FINISH")
  end


  def rocket do
    IO.puts("MAIN THREAD START")
    ["Columbia", "Eterprise", "Atlantis", "Discovery"]
    #Sequentially
    #|> Enum.map(&count(&1, 10))

    #Concurrency using tasks
    |> Enum.map(&Task.start(fn -> count(&1, 10) end))
    |> IO.inspect()
    IO.puts("MAIN THREAD FINISH")
  end

  def multi_sums(limit, threads) do
    IO.puts("MAIN THREAD STARt")
    1..threads
    |> Enum.map(&Task.async(fn->sum(&1, limit) end)) #Con start, no espera ni nada, con async puedo esperar a que los threads terminen para realizar operaciones con ellos
    |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    |> IO.inspect()

    |>Enum.sum()
    |>IO.inspect()
    IO.puts("MAIN THREAD FINISH")
  end

  def timer(func) do
    func
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  #Como obtener la lista de archivos para que los procese

end
