class ProductSerializer
  include JSONAPI::Serializer

  cache_options store: Rails.cache, namespace: "jsonapi-serializer", expires_in: 1.hour

  attributes :title, :price, :published
  belongs_to :user
end
