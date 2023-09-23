defmodule Pokeball.ScrapeMe do
  alias Pokeball.Pagination

  require Logger

  @client Application.compile_env!(:pokeball, :scrape_me_client)

  def start_scrape do
    with {:ok, html_body} <- request_start_page(),
         pagination_elements <- Pagination.find_pagination(html_body),
         {:ok, page} <- Pagination.parse_pagination(pagination_elements) do
      {:ok, page}
    end
  end

  def request_start_page do
    case @client.get("/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: html_body}} ->
        {:ok, html_body}

      {_, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(body)
        {:error, "Received status code: #{status_code}"}
    end
  end
end
