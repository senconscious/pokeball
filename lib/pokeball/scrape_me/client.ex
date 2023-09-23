defmodule Pokeball.ScrapeMe.Client do
  use HTTPoison.Base

  require Logger

  def process_request_url(url) do
    "https://scrapeme.live/shop" <> url
  end

  def process_response_body(binary) do
    case Floki.parse_document(binary) do
      {:ok, parsed_html} ->
        parsed_html

      {:error, reason} ->
        Logger.error(reason)
        binary
    end
  end
end
