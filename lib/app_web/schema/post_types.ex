defmodule AppWeb.Schema.PostTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  interface :post do
    field :type, :string
    resolve_type fn
      %{type: :image_post}, _ -> :image_post
      %{type: :youtube_post}, _ -> :youtube_post
      _, _ -> nil
    end
  end

  node object :image_post do
    field :type, :string
    field :image_url, :string
  end

  node object :sale_post do
    field :type, :string
    field :sale_title, :string
  end

end
