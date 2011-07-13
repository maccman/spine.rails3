class StitchApplication < Stitch::Server
  def initialize
    super(:paths => ["app/assets/javascripts/app", "app/assets/javascripts/lib"])
  end
end