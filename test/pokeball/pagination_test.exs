defmodule Pokeball.PaginationTest do
  use ExUnit.Case

  alias Pokeball.Pagination

  alias Pokeball.Pagination.Page

  test "successfully parses pagination" do
    assert {:ok, pagination} = Pagination.parse_pagination("Showing 1–16 of 755 results")

    assert pagination == %Page{page: 1, page_size: 16, total_pages: 48}

    assert {:ok, pagination} = Pagination.parse_pagination("Showing 17–32 of 755 results")

    assert pagination == %Page{page: 2, page_size: 16, total_pages: 48}
  end
end
