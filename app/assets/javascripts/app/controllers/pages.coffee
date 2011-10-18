$ = jQuery

class PagesEdit extends Spine.Controller
  events:
    'click .back': 'back'
    'submit form': 'update'

  constructor: ->
    super
    @active (params) ->
      @change Page.find(params.id)

  render: =>
    @html $.tmpl('app/views/pages/edit', @item)

  change: (item) ->
    @item = item
    @render()

  update: (e) ->
    e.preventDefault()
    @item.updateAttributes($(e.target).serializeForm())
    @back()
   
  back: ->
    @navigate '/pages', @item.id
  
class PagesItem extends Spine.Controller
  events:
    'click .back': 'back'
    'click .edit': 'edit'
    'click .destroy': 'destroyItem'
    
  constructor: ->
    super
  
    Page.bind 'change', (item) => 
      @render() if item.eql(@item)

    @active (params) ->
      @change Page.find(params.id)
    
  render: =>
    @html $.tmpl('app/views/pages/show', @item)
    
  change: (item) ->
    @item = item
    @render()

  destroyItem: ->
    @item.destroy()
    @back()

  edit: ->
    @navigate '/pages', @item.id, 'edit'
    
  back: ->
    @navigate '/pages'
    
class PagesList extends Spine.Controller
  className: 'list'
  
  elements: 
    '.items': 'items'
  
  events:
    'click .item': 'show'
    'click .create': 'create'
    
  constructor: ->
    super
    @html $.tmpl('app/views/pages/list')
    Page.bind('refresh change', @render)
    
  render: =>
    items = Page.all()
    @items.html $.tmpl('app/views/pages/item', items)
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/pages', item.id
    
  create: (e) ->
    item = Page.create(name: 'Dummy page')
    @navigate '/pages', item.id, 'edit'

class Pages extends Spine.Controller
  constructor: ->    
    super
    @list = new PagesList
    @edit = new PagesEdit
    @item = new PagesItem
    
    new Spine.Manager(@list, @edit, @item)
    
    @append(@list, @edit, @item)
    
    @routes
      '/pages/:id/edit': (params) ->
        @edit.active(params)
      '/pages/:id': (params) ->
        @item.active(params)
      '/pages': (params) -> 
        @list.active(params)

    @navigate '/pages'
        
    # Only setup routes once pages have loaded
    Page.bind 'refresh', -> 
      Spine.Route.setup()

    Page.fetch()
  
window.Pages = Pages