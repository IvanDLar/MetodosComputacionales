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
      |> File.stream!()
      |> Enum.map(&change_object_key/1)
      |> Enum.map(&change_string/1)
      |> Enum.map(&change_numbers/1)
      |> Enum.map(&change_punctuation/1)
      |> Enum.map(&change_booleans/1)
      |> Enum.map(&change_punctuation_curly_bracket/1)
      |> Enum.map(&change_punctuation_square_bracket/1)
      |>Enum.map(&replaceNewlines/1)
      |>Enum.map(&replaceTabs/1)

    File.write(out_filename, text)
  end

  defp change_object_key(line) do
    #Replace all of the "object keys" for their equivalent in html format
    regex = ~r/"(.{1,})"\s*(?=:)/
    Regex.replace(regex, line,
                  "<span class = 'object_key'> \\1 </span>")
  end

  defp change_string(line) do
    #Replace all of the "strings" for their equivalent in html format
    regex = ~r/("(.{1,})"(?!:))/
    Regex.replace(regex, line,
                  "<span class = 'string'> \\1 </span>")
  end

  defp change_punctuation(line) do
    regex = ~r/(;|,|:){1,}(?![^"]*")/
    Regex.replace(regex, line,
                  "<span class = 'punctuation'> \\1 </span>")
  end

  defp change_punctuation_curly_bracket(line) do
    regex = ~r/({|})/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-curly-bracket'>\\1 </span>")
  end

  defp change_punctuation_square_bracket(line) do
    regex = ~r/(\[|\])/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-square-bracket'> \\1 </span>")
  end

  defp change_numbers(line)do
    regex = ~r/([0-9E+-.](?![^"]*"))/
    Regex.replace(regex, line, "<span class = 'numbers'> \\1 </span>")
  end

  defp change_booleans(line) do
    regex = ~r/(true|false|null)/
    Regex.replace(regex, line, "<span class = 'boolean'> \\1 </span>")
  end

  def replaceNewlines(line) do
    # replace new lines with html enter simbol
    regex = ~r/\n/
    Regex.replace(regex, line, "<br>")
  end

  def replaceTabs(line) do
    # replace 2 line indentations
    regex = ~r/\s{2,4}/
    Regex.replace(regex, line, "&nbsp;&nbsp;")
  end

end
