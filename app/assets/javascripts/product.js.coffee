window.Product =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    window.routerProducts   = new Product.Routers.Products()
    Backbone.history.start()

$ ->
  $("div#navigation ul.nav").on "click", "a", ->
    section = $(this).text()
    $(this).closest("ul").find("li").removeClass "current"
    $(this).parent().addClass "current"
  Product.init()

# Helper functions
window.ViewsHelpers =

  processInputs: (form, model) ->
    inputs = $(form).find(".inputs").children(":input")
    attributes = {}
    _.each inputs, (input, a) ->
      inputVal = $(input).val()
      if inputVal.length
        inputName = $(input).attr("id")
        attributes[inputName] = inputVal unless inputVal is model.get(inputName)
    attributes

