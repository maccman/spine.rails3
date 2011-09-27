require 'uri'

module JuggernautHelper
  def juggernaut_meta_tags
    tag('meta', :name => 'juggernaut-host', :content => juggernaut_uri.host) + 
      tag('meta', :name => 'juggernaut-port', :content => juggernaut_uri.port)
  end
  
  def juggernaut_uri
    URI.parse(ENV['JUGGERNAUT_URL'] || 'http://localhost:8080')
  end
end
