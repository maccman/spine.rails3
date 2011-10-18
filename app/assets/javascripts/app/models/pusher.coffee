#= require pusher

$ = jQuery

class PusherHandler extends Spine.Module
  @include Spine.Log
  logPrefix: '(Pusher)'
  
  constructor: (@options = {}) ->
    @options.key or= $('meta[name=pusher-key]').attr('content')
    
    @pusher = new Pusher(@options.key, @options)

    $.ajaxSetup
      beforeSend: (xhr) =>
        xhr.setRequestHeader 'X-Session-ID', @pusher.connection.socket_id

    @channel = @pusher.subscribe 'observer'
    @channel.bind_all @processWithoutAjax
  
  process: (type, msg) =>
    @log 'process:', type, msg
    
    klass = eval(msg.class)
    switch type
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
    
$ -> new PusherHandler