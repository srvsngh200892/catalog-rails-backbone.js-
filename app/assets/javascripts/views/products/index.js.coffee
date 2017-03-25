class Product.Views.ProductsIndex extends Backbone.View

  el: '.content'

  events:
    "click #show-modal": "showModal"


  template: HandlebarsTemplates['products/index']

  initialize: ->
    self = this
    @products = new Product.Collections.Products();
    @products.fetch
      reset: true
      success: (collection, response) ->
        self.render()
        self.addAll()



  addAll: ->
    @products.forEach(@addOne, @)

  addOne: (model) ->
    @view = new Product.Views.ProductsProduct({model: model})
    @$el.find('tbody').append @view.render().el

  render: ->
    @$el.html @template()
    @

  showModal: ->
    view = new Product.Views.ProductsNew({collection: @products})
    view.render()
