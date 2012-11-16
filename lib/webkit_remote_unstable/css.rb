module WebkitRemote

class Client

# API for the unstable CSS domain.
module Css
  # Enables or disables the generation of events in the CSS domain.
  #
  # @param [Boolean] new_css_events if true, the browser debugger will
  #     generate CSS.* events
  def css_events=(new_css_events)
    new_css_events = !!new_css_events
    if new_css_events != css_events
      @rpc.call(new_css_events ? 'CSS.enable' : 'CSS.disable')
      @css_events = new_css_events
    end
    new_css_events
  end

  # Cleans up all the CSS-related state.
  #
  # @return [WebkitRemote::Client] self
  def clear_css
    self
  end

  # @return [Boolean] true if the debugger generates css.* events
  attr_reader :css_events

  # @private Called by the Client constructor to set up css data.
  def initialize_css
    @css_events = false
  end
end  # module WebkitRemote::Client::Css

initializer :initialize_css
clearer :clear_css
include WebkitRemote::Client::Css

class DomNode
  # @return [Hash<Symbol, String>] computed CSS attributes for this node
  def computed_style
    @computed_style ||= computed_style!
  end

  # Gets the node's computed CSS attributes, bypassing the node cache.
  #
  # @return [Hash<Symbol, String>] computed CSS attributes for this node
  def computed_style!
    result = @client.rpc.call 'CSS.getComputedStyleForNode', nodeId: @remote_id
    @computed_style = Hash[result['computedStyle'].map { |property|
      [property['name'].gsub('-', '_').to_sym, property['value']]
    }]
  end

  # @private Called by the DomNode constructor
  def initialize_css
    @computed_style = nil
  end
  initializer :initialize_css
end  # namespace WebkitRemote::Client::DomNode

end  # namespace WebkitRemote::Client

end  # namespace WebkitRemote
