defmodule Pokeball.PokemonsTest do
  use ExUnit.Case, async: true

  alias Pokeball.Pokemons

  alias Pokeball.Pokemons.Pokemon

  setup do
    parsed_data =
      "test/support/priv/start_page_response.html"
      |> File.read!()
      |> Floki.parse_document!()

    expected_pokemons =
      "test/support/priv/start_pokemons.json"
      |> File.read!()
      |> Jason.decode!()
      |> Enum.map(&build_pokemon/1)

    {:ok, parsed_data: parsed_data, expected_pokemons: expected_pokemons}
  end

  test "successfully parses pokemons", %{
    parsed_data: parsed_data,
    expected_pokemons: expected_pokemons
  } do
    assert {:ok, pokemons} = Pokemons.parse_pokemons(parsed_data)

    assert pokemons == expected_pokemons
  end

  defp build_pokemon(%{
         "id" => id,
         "name" => name,
         "price" => price,
         "sku" => sku,
         "image_url" => image_url
       }) do
    %Pokemon{
      id: id,
      name: name,
      price: price,
      sku: sku,
      image_url: image_url
    }
  end
end
