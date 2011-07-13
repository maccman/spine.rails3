class App extends Spine.Controller
  elements:
    "#pages": "pagesEl"
  
  constructor: ->
    super
    
    alert('Loaded!')
    
    
module.exports = App