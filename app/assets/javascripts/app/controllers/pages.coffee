$    = jQuery
Page = require("models/page")

class PagesItem extends Spine.Controller
  events:
    "click .destroy": "destroy"
    "click .edit": "edit"
    "submit form": "update"
    
  constructor: ->
    throw("item required") unless @item
    @item.bind("destroy", @remove)
    @item.bind("update", @render)
    
  render: =>
    @html require("views/pages/show")(@item)

  update: (e) ->
    e.preventDefault()
    @item.updateAttributes($(e.target).serializeForm())
    @el.removeClass("edit")
    
  edit: ->
    @el.addClass("edit")
    
  destroy: ->
    @item.destroy()
    
  remove: ->
    @el.remove()
    
class PagesList extends Spine.Controller
  events:
    "click .item": "show"
    "click .create": "create"
    
  constructor: ->
    Page.bind("refresh", @addAll)
    Page.bind("create", @addOne)
    
  addAll: =>
    @el.empty()
    @addOne(page) for page in Page.all()
    
  addOne: (page) =>
    @append(new PagesItem(item: page).render())    
    
  show: (e) ->
    item = $(e.target).item()
    @navigate("/pages", item.id)
    
  create: (e) ->
    Page.create(name: "Sample page")

class Pages extends Spine.Controller
  constructor: ->    
    @list = new PagesList
    @item = new PagesItem
    
    @manager = new Spine.Manager(@list, @item)
    
    @append(@list, @item)
    
    @routes
      "/pages": (params) -> 
        @list.active(params)
      "/pages/:id": (params) ->
        @item.change Page.find(params.id)
        @item.active(params)
  
    Page.fetch()
  
module.exports = Pages