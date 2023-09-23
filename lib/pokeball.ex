defmodule Pokeball do
  @moduledoc """
  Documentation for `Pokeball`.
  """

  alias Pokeball.Pagination.Page
  alias Pokeball.ScrapeMe

  require Logger

  @doc """
    Starts pokemon scrapper
  """
  def scrap_them_all do
    with {:ok, page, pokemons} <- ScrapeMe.start_scrape(),
         _ <- Logger.info("Scrapped first page"),
         {:ok, pokemons} <- scrape_pages(page, pokemons) do
      File.write!("result.json", Jason.encode!(pokemons))
    end
  end

  defp scrape_pages(%Page{page: current_page, total_pages: total_pages} = page, pokemons)
       when current_page < total_pages do
    with {:ok, new_pokemons} <- ScrapeMe.scrape_page(current_page + 1) do
      Logger.info("Scrapped #{current_page + 1} / #{total_pages}")
      Process.sleep(5_000)
      scrape_pages(struct(page, page: current_page + 1), Enum.concat(pokemons, new_pokemons))
    end
  end

  defp scrape_pages(_page, pokemons) do
    {:ok, Enum.uniq_by(pokemons, fn %{id: id} -> id end)}
  end
end
