defmodule Pokeball.Utils do
  @moduledoc """
    Provides some utils for dev experience
  """

  def save_response(url \\ "https://scrapeme.live/shop/", file \\ "start_page_response.html") do
    with {:ok, %{body: body}} <- HTTPoison.get(url) do
      File.write!("test/support/priv/#{file}", body)
    end
  end

  def save_pokemons(list_of_pokemons, file \\ "start_pokemons.json") do
    list_of_pokemons
    |> Enum.map(&Map.from_struct/1)
    |> Jason.encode!()
    |> then(&File.write!("test/support/priv/#{file}", &1))
  end
end
