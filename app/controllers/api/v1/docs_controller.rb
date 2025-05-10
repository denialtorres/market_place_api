module Api
  module V1
    class DocsController < ActionController::Base
      layout false

      def index
        @api_endpoints = [
          {
            endpoint: "/api/v1/users",
            methods: [ "GET", "POST" ],
            description: "List all users or create a new user",
            params: {
              user: {
                email: "string",
                password: "string"
              }
            }
          },
          {
            endpoint: "/api/v1/users/:id",
            methods: [ "GET", "PATCH", "PUT", "DELETE" ],
            description: "Show, update or delete a specific user",
            params: {
              user: {
                email: "string",
                password: "string"
              }
            }
          },
          {
            endpoint: "/api/v1/tokens",
            methods: [ "POST" ],
            description: "Generate JWT token for authentication",
            params: {
              user: {
                email: "string",
                password: "string"
              }
            }
          },
          {
            endpoint: "/api/v1/products",
            methods: [ "GET", "POST" ],
            description: "List all products or create a new product",
            params: {
              product: {
                title: "string",
                price: "decimal",
                published: "boolean"
              }
            }
          },
          {
            endpoint: "/api/v1/products/:id",
            methods: [ "GET", "PATCH", "PUT", "DELETE" ],
            description: "Show, update or delete a specific product",
            params: {
              product: {
                title: "string",
                price: "decimal",
                published: "boolean"
              }
            }
          },
          {
            endpoint: "/api/v1/orders",
            methods: [ "GET", "POST" ],
            description: "List all orders or create a new order",
            params: {
              order: {
                total: "decimal",
                user_id: "integer"
              }
            }
          },
          {
            endpoint: "/api/v1/orders/:id",
            methods: [ "GET" ],
            description: "Show a specific order"
          }
        ]
      end
    end
  end
end
