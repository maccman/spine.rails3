class JuggernautObserver < ActiveRecord::Observer
  observe :page
    
  def after_create(rec)
    publish(:create, rec)
  end
  
  def after_update(rec)
    publish(:update, rec)
  end
  
  def after_destroy(rec)
    publish(:destroy, rec)
  end
  
  protected
    def publish(type, rec)
      Juggernaut.publish(
        "/observer",
        { 
          type:   type, 
          id:     rec.id, 
          class:  rec.class.name, 
          record: rec
         },
        :except => rec.session_id
      )
    end
end