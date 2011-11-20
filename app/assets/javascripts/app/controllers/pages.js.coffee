$ = jQuery.sub()
Page = App.Page

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Page.find(elementID)

class New extends Spine.Controller
  events:
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('pages/new')
    
  submit: (e) ->
    e.preventDefault()
    page = Page.fromForm(e.target).save()
    @navigate '/pages', page.id if page

class Edit extends Spine.Controller
  events:
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Page.find(id)
    @render()
    
  render: ->
    @html @view('pages/edit')(@item)
    
  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/pages'

class Show extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'click [data-type=edit]': 'edit'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Page.find(id)
    @render()

  render: ->
    @html @view('pages/show')(@item)

  back: ->
    @navigate '/pages'
    
  edit: ->
    @navigate '/pages', @item.id, 'edit'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Page.bind 'refresh change', @render
    Page.fetch()
    
  render: =>
    pages = Page.all()
    @html @view('pages/index')(pages: pages)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/pages', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/pages', item.id
    
  new: ->
    @navigate '/pages/new'
    
class App.Pages extends Spine.Stack
  className: 'pages stack'
  
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/pages/new':      'new'
    '/pages/:id/edit': 'edit'
    '/pages/:id':      'show'
    '/pages':          'index'
    '':                'index'
    
  className: 'stack pages'