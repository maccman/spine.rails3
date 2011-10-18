require 'uri'

module PusherHelper
  def pusher_meta_tags
    tag('meta', :name => 'pusher-key', :content => Pusher.key)
  end
end
