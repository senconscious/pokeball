defmodule Pokeball.ScrapeMeTest do
  use ExUnit.Case

  alias Pokeball.ScrapeMe

  test "start scrape returns parsed first page" do
    assert {:ok, pagination} = ScrapeMe.start_scrape()
  end
end
