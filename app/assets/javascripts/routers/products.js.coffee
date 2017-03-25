class Product.Routers.Products extends Backbone.Router

  routes:
    ""  : "index"

  index: ->
    @view = new Product.Views.ProductsIndex()


