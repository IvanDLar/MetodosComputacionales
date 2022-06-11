# Actividad 5.3 Resaltador de Sintaxis

# Ivan Diaz Lara A01365801
# Octavio Fenollosa A01781042
# 2022-06-10
#

defmodule Resaltador do
  @moduledoc """
  Extract multiple files from a specified folder, read their syntax, translate
  it to HTML and write it down in a new ".html" file.
  """
  @doc """
  Extract the files from the specified folder.
  """
  def read_multi_file() do
    File.ls("./SimpleTests")
    |> elem(1)
    |> Enum.map(&read_file/1)
  end

  @doc """
  Extract the files from the specified folder using parallelism.
  """
    def read_multi_file_parallel()do
    File.ls("./SimpleTests")
    |> elem(1)
    |> Enum.map(&Task.start(fn -> read_file(&1) end))
  end

  @doc """
  Read the specified file line by line and replace the matches found with regex.replace.
  """
  def read_file(in_filename) do

    # Using pipe operator to link the calls
    head = File.read!("template_head.html")
    footer = File.read!("template_footer.html")

    text =
      "./SimpleTests/#{in_filename}"
      |> File.stream!()
      |> Enum.map(&change_object_key/1)
      |> Enum.map(&change_string/1)
      |> Enum.map(&change_numbers/1)
      |> Enum.map(&change_punctuation/1)
      |> Enum.map(&change_booleans/1)
      |> Enum.map(&change_punctuation_curly_bracket/1)
      |> Enum.map(&change_punctuation_square_bracket/1)
      |> Enum.map(&change_NewLines/1)
      |> Enum.map(&change_Indentations/1)

    File.write(Regex.replace(~r/(.json)$/, in_filename, ".html"), [head | text] ++ footer) #Creates new html file with the text modifications

    end

  defp change_object_key(line) do
    #Replace all of the "object keys" for their equivalent in html format
    #Regex will only mach if there is a : character after the string
    regex = ~r/\"([^\"]*)\"(?=\s*:)/
    Regex.replace(regex, line,
                  "<span class = 'object_key'> \\1 </span>")
  end

  defp change_string(line) do
    #Replace all of the "strings" for their equivalent in html format
    #Regex will only mach if there isn't a : character after the string
    regex = ~r/("(.{1,})"(?!:))/
    Regex.replace(regex, line,
                  "<span class = 'string'> \\1 </span>")
  end

  defp change_punctuation(line) do
    #Replace punctuation with the html equivalent
    #Regex wont match if any punct is within quotes
    regex = ~r/(:|,|;)(?=([^"]*"[^"]*")*[^"]*$)(?!")/
    Regex.replace(regex, line,
                  "<span class = 'punctuation'> \\1 </span>")
  end

  defp change_punctuation_curly_bracket(line) do
    #Replace c_brackets with the html equivalent
    #Regex will match the curly bracket characters
    regex = ~r/({|})/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-curly-bracket'>\\1 </span>")
  end

  defp change_punctuation_square_bracket(line) do
    #Replace s_brackets with the html equivalent
    #Regex will match the square bracket characters
    regex = ~r/(\[|\])/
    Regex.replace(regex, line,
                  "<span class = 'punctuation-square-bracket'> \\1 </span>")
  end

  defp change_numbers(line)do
    #Replace numbers with the html equivalent
    #Regex wont match if any num is within quotes
    regex = ~r/(([E\-\+\d\.]+)(?=([^"]*"[^"]*")*[^"]*$)(?!"))/
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
    #Replace tab indentations with their html counterpart
    regex = ~r/\t{1,}/
    Regex.replace(regex, line, "&nbsp;")
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
