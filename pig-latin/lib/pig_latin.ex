defmodule PigLatin do
  @consonant_regex ~r/^(?<prefix>(([ybcdfghklmnpqrstvwxz]qu)|[ybcdfghklmnpqrstvwxz]+))(?<rest>.*)/i
  @vowel_regex ~r/^[aeiou]|(yt|xr|xb)/i
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
      |> String.split(" ")
      |> Enum.map(&translate_word/1)
      |> Enum.join(" ")
  end

  def translate_word(word) do
    cond do
      word =~ @vowel_regex -> translate_vowel_prefix(word)
      word =~ @consonant_regex -> translate_consonant_prefix(word)
      word -> IO.inspect(word)
    end
  end

  def translate_vowel_prefix(word) do
    word <> "ay"
  end

  def translate_consonant_prefix(word) do
    case Regex.named_captures(@consonant_regex, word) do

      %{"prefix" => prefix, "rest" => rest} -> rest <> prefix <> "ay"
    end
  end
end
