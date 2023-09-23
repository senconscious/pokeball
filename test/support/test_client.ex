defmodule Pokeball.ScrapeMe.TestClient do
  def get("/") do
    body = File.read!("test/support/priv/start_page_response.html")
    {:ok, %HTTPoison.Response{status_code: 200, body: body}}
  end
end
