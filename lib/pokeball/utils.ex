defmodule Pokeball.Utils do
  @moduledoc """
    Provides some utils for dev experience
  """
  def save_response(url \\ "https://scrapeme.live/shop/", file \\ "start_page_response.html") do
    with {:ok, %{body: body}} <- HTTPoison.get(url) do
      File.write!("test/support/priv/#{file}", body)
    end
  end
end
