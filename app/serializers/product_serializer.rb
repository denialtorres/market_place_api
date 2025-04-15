class ProductSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :published
end
