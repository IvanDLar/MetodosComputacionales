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
      |> Enum.map(&change_object_key/1)\
      |> Enum.map(&change_string/1)

    File.write(out_filename, text)
  end
#Object key
#Punctuation
#String
#Number
#Reserved Word

  defp change_object_key(line) do

    regex = ~r/("(.{1,})":)/
    Regex.replace(regex, line,
                  "<span class = 'object_key' > \1 </span>")
  end

  defp change_string(line) do
    #Replace all of the "strings" for their equivalent in html format
    regex = ~r/".{1,}"/

    Regex.replace(regex, line,
                  "<span class = 'string'> \1 </span>")

  end


  #defp change_punctuation() do Regex.replace()

  #defp change_reserved_word(), do: Regex.replace()

end
