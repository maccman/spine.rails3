#= require juggernaut

$ = jQuery

class JuggernautHandler extends Spine.Module
  @include Spine.Log
  logPrefix: '(Juggernaut)'
  
  constructor: (@options = {}) ->
    @options.host or= $('meta[name=juggernaut-host]').attr('content')
    @options.port or= $('meta[name=juggernaut-port]').attr('content')
    @options.transports or= [
      'xhr-multipart', 
      'xhr-polling', 
      'jsonp-polling'
    ]
    
    @jug = new Juggernaut(@options)
    
    @jug.on 'connect',    => @log 'connected'
    @jug.on 'disconnect', => @log 'disconnected'
    @jug.on 'reconnect',  => @log 'reconnecting'

    $.ajaxSetup
      beforeSend: (xhr) =>
        xhr.setRequestHeader 'X-Session-ID', @jug.sessionID

    @jug.subscribe '/observer', @processWithoutAjax
  
  process: (msg) =>
    @log 'process', msg
    
    klass = window[msg.class]
    switch msg.type
      when 'create'
        klass.create msg.record unless klass.exists(msg.record.id)
      when 'update'
        klass.update msg.id, msg.record
      when 'destroy'
        klass.destroy msg.id
      else
        throw 'Unknown type:' + type
      
  processWithoutAjax: =>
    args = arguments
    Spine.Ajax.disable =>
      @process(args...)
    
$ -> new JuggernautHandler