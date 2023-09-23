defmodule Pokeball.Pagination.Page do
  @type t :: %__MODULE__{
          page: integer(),
          page_size: integer(),
          total_pages: integer()
        }

  @enforce_keys [:page, :total_pages, :page_size]
  defstruct [:page, :total_pages, :page_size]
end
