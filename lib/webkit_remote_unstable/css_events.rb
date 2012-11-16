module WebkitRemote

class Event

# Emitted when the result of CSS media queries changes.
class MediaQueryResultChanged < WebkitRemote::Event
  register 'CSS.mediaQueryResultChanged'

  # @private Use Event#for instead of calling this constructor directly.
  def initialize(rpc_event, client)
    super
  end

  # @private Use Event#can_receive instead of calling this directly.
  def self.can_reach?(client)
    client.css_events
  end
end  # class WebkitRemote::Event::MediaQueryResultChanged

end  # namespace WebkitRemote::Event

end  # namepspace WebkitRemote
