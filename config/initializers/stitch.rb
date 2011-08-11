class StitchApplication
  def initialize
    @package = Stitch::Package.new(:paths => ["app/assets/javascripts/app", "app/assets/javascripts/lib"])
  end
  
  def call(env)
    [200, {"Content-Type" => "text/javascript"}, [Uglifier.compile(@package.compile)]]
  end
end