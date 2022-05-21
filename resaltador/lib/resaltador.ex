defmodule Resaltador do
  @moduledoc """
  Documentation for `Resaltador`.
  """

  @doc """
  Resaltador de Sintaxis
  Ivan Diaz Lara A01365801
  """
  def read_file(in_filename, out_filename) do
    # Single expression of nested calls
    stream = File.stream!(in_filename)

    # Using pipe operator to link the calls
    head = File.read!("template_head.html")
    footer = File.read!("template_footer.html")

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
      |>Enum.map(&change_NewLines/1)
      |>Enum.map(&change_Indentations/1)

    File.write(out_filename, [head | text] ++ footer ) #Creates new html file with the text modifications
  end

  defp change_object_key(line) do
    #Replace all of the "object keys" for their equivalent in html format
    regex = ~r/"(.{1,})"(?=:)/
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
    #Replace punctuation with the html equivalent
    regex = ~r/(;|,|:){1,}(?![^"]*")/ #Regex wont match if any punct is within quotes
    Regex.replace(regex, line,
                  "<span class = 'punctuation'> \\1 </span>")
  end

  defp change_punctuation_curly_bracket(line) do
    #Replace c_brackets with the html equivalent
    regex = ~r/({|})/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-curly-bracket'>\\1 </span>")
  end

  defp change_punctuation_square_bracket(line) do
    #Replace s_brackets with the html equivalent
    regex = ~r/(\[|\])/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-square-bracket'> \\1 </span>")
  end

  defp change_numbers(line)do
    #Replace numbers with the html equivalent
    regex = ~r/(([E\-\+\d]){1,}(?![^"]*"))/ #Regex wont match if any num is within quotes
    Regex.replace(regex, line, "<span class = 'numbers'> \\1 </span>")
  end

  defp change_booleans(line) do
    #Replace booleans with the html equivalent
    regex = ~r/(true|false|null)/
    Regex.replace(regex, line, "<span class = 'boolean'> \\1 </span>")
  end

  defp change_NewLines(line) do
    #Replace new lines with html enter simbol
    regex = ~r/\n/
    Regex.replace(regex, line, "<br>")
  end

  defp change_Indentations(line) do
    #Replace 2 line indentations
    regex = ~r/\t{1,}/
    Regex.replace(regex, line, "&nbsp;")
  end

end
