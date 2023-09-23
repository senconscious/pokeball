defmodule Pokeball.ScrapeMe.TestClient do
  @moduledoc """
    Provides test http client for scrape me website
  """

  def get("/") do
    body = File.read!("test/support/priv/start_page_response.html")
    {:ok, %HTTPoison.Response{status_code: 200, body: body}}
  end
end
