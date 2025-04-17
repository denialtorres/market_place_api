class OrderSerializer
  include JSONAPI::Serializer

  cache_options store: Rails.cache, namespace: "jsonapi-serializer", expires_in: 1.hour

  belongs_to :user
  has_many :products
end
