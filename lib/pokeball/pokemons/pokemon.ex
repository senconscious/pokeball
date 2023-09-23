defmodule Pokeball.Pokemons.Pokemon do
  @moduledoc """
    Provides Pokemon struct
  """

  @type t :: %__MODULE__{
          id: binary(),
          name: binary(),
          price: binary(),
          sku: binary(),
          image_url: binary()
        }

  @enforce_keys [:id, :name, :price, :sku, :image_url]
  defstruct [:id, :name, :price, :sku, :image_url]
end
