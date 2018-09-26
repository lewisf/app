defmodule AppWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias Absinthe.Relay

  node object :product_price_range do
    field :max_variant_price, :float
    field :min_variant_price, :float
  end

  node object :product do
    field :title, :string
    field :created_at, :datetime
    field :description, :string
    field :descriptionHtml, :string
    field :has_only_default_variant, :boolean
    field :has_out_of_stock_variants, :boolean
    field :price_range, :product_price_range
    field :total_inventory, :integer
    field :total_variants, :integer
    field :title, :string
  end

  node object :product_variant do
    field :available_for_sale, :boolean
    field :compare_at_price, :integer
    field :display_name, non_null(:string)
    field :position, :integer
    field :price, :float
    field :sku, :string
    field :title, :string
    field :weight, :float
  end

  node object :selected_option do
    field :name, :string
    field :value, :string
  end
end
