defmodule Resaltador do
  @moduledoc """
  Documentation for `Resaltador`.
  """

  @doc """
  Resaltador de Sintaxis

  """
  def read_file(in_filename, out_filename) do
    # Single expression of nested calls
    stream = File.stream!(in_filename)

    # Using pipe operator to link the calls
    text =
      in_filename
      |> File.stream!() \
      |> Enum.map(&String.split/1)
      #|> IO.inspect()
      |> Enum.map(&(Enum.join(&1, "-")))
      #|> IO.inspect()
      |> Enum.join("\n")
    File.write(out_filename, text)
  end
#Object key
#Punctuation
#String
#Number
#Reserved Word

  defp change_object_key(line), do: Regex.replace(~r/"(.{1,})":/, line, "<keyS>\1<keyE>"~r//)

  defp change_punctuation(line), do: Regex.replace(~r/.{1,}/, line, )

  defp change_string(), do: Regex.replace()

  defp change_number(), do: Regex.replace()

  defp change_reserved_word(), do: Regex.replace()

end
