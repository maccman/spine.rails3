class App.Page extends Spine.Model
  @configure 'Page', 'name', 'body'
  @extend Spine.Model.Ajax
  
  validate: ->
    'name required' unless @name