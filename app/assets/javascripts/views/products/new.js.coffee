class Product.Views.ProductsNew extends Backbone.View
  el: '.modal'

  template: HandlebarsTemplates['products/new_modal']


  events:
    "click #save_product": "saveProduct"

  render: ->
    @$el.html(@template())
    @$el.modal()
    @

  saveProduct: (e) ->
    e.preventDefault()
    e.stopPropagation()
    attributes =
      name: @$("#name").val()
      price: @$("#price").val()
      description: @$("#description").val()
    model = new Product.Models.Product(attributes)
    @collection.create model,
      success: (product) =>
        @model = product
        window.location = "/"
      error:(response) ->
        alert "There were errors!. Please fill the form correctly"
