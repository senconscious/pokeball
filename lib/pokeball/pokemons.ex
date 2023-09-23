defmodule Pokeball.Pokemons do
  alias Pokeball.Pokemons.Pokemon

  require Logger

  @name_pattern ~r/Add “([a-zA-Z\-\_0-9]+)” to your basket/

  def parse_pokemons(parsed_html) do
    with {:ok, raw_pokemons} <- find_raw_pokemons(parsed_html) do
      {:ok, parse_raw_pokemons(raw_pokemons)}
    end
  end

  defp find_raw_pokemons(parsed_html) do
    case Floki.find(parsed_html, ".product") do
      [] ->
        {:error, "Failed to find raw pokemons"}

      raw_pokemons ->
        {:ok, raw_pokemons}
    end
  end

  defp parse_raw_pokemons(raw_pokemons) do
    Enum.map(raw_pokemons, fn item ->
      button = Floki.find(item, "li a.button")

      %Pokemon{
        id: button |> Floki.attribute("data-product_id") |> List.first(),
        name: button |> Floki.attribute("aria-label") |> List.first() |> parse_name(),
        sku: button |> Floki.attribute("data-product_sku") |> List.first(),
        image_url: item |> Floki.find("li img") |> Floki.attribute("src") |> List.first(),
        price: item |> Floki.find(".amount") |> Floki.text()
      }
    end)
  end

  defp parse_name(aria_label) do
    case Regex.scan(@name_pattern, aria_label) do
      [[_aria_label, name]] ->
        name

      _error ->
        Logger.error("Failed to extract name from #{aria_label}")
        "UNDEFINED NAME"
    end
  end
end
