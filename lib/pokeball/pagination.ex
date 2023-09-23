defmodule Pokeball.Pagination do
  alias Pokeball.Pagination.Page

  @pattern ~r/Showing ([0-9]+)–([0-9]+) of ([0-9]+) results/

  def find_pagination(parsed_body) do
    Floki.find(parsed_body, ".woocommerce-result-count")
  end

  def parse_pagination([]), do: {:error, "Pagination not found"}

  def parse_pagination([pagination_string | _]) do
    pagination_string
    |> Floki.text()
    |> String.trim()
    |> parse_pagination()
  end

  def parse_pagination(pagination_string) when is_binary(pagination_string) do
    case Regex.scan(@pattern, pagination_string) do
      [[_initial_string, start_element, end_element, total_elements]] ->
        build_page(start_element, end_element, total_elements)

      _ ->
        {:error, "Failed to extract pagination info from #{pagination_string}"}
    end
  end

  defp build_page(start_element, end_element, total_elements)
       when is_binary(start_element) and is_binary(end_element) and is_binary(total_elements) do
    build_page(
      String.to_integer(start_element),
      String.to_integer(end_element),
      String.to_integer(total_elements)
    )
  end

  defp build_page(start_element, end_element, total_elements)
       when is_integer(start_element) and is_integer(end_element) and is_integer(total_elements) do
    page_size = end_element - start_element + 1
    total_pages = ceil(total_elements / page_size)
    page = ceil(start_element / page_size)

    {:ok, %Page{page: page, page_size: page_size, total_pages: total_pages}}
  end

  defp build_page(_, _, _), do: {:error, "Failed to build page"}
end
