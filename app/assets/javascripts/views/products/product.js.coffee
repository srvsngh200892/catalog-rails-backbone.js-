class Product.Views.ProductsProduct extends Backbone.View
  template: HandlebarsTemplates["products/product"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    @$el.html(@template(@model.toJSON()))
    return this
