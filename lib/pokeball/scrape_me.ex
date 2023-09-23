defmodule Pokeball.ScrapeMe do
  @moduledoc """
    Provides function to scrape scrape me website
  """

  alias Pokeball.Pagination
  alias Pokeball.Pokemons

  require Logger

  @client Application.compile_env!(:pokeball, :scrape_me_client)

  def start_scrape do
    with {:ok, html_body} <- request_start_page(),
         pagination_elements <- Pagination.find_pagination(html_body),
         {:ok, page} <- Pagination.parse_pagination(pagination_elements),
         {:ok, pokemons} <- Pokemons.parse_pokemons(html_body) do
      {:ok, page, pokemons}
    end
  end

  def scrape_page(page) do
    with {:ok, html_body} <- request_page(page) do
      Pokemons.parse_pokemons(html_body)
    end
  end

  defp request_page(page) do
    case @client.get("/page/#{page}/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: html_body}} ->
        {:ok, html_body}

      {_, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(body)
        {:error, "Received status code: #{status_code}"}
    end
  end

  defp request_start_page do
    case @client.get("/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: html_body}} ->
        {:ok, html_body}

      {_, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(body)
        {:error, "Received status code: #{status_code}"}
    end
  end
end
