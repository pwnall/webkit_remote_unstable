module WebkitRemote

class Client

# Unstable API for the DOM domain.
module Dom
  # Retrieves the node at a given location.
  #
  # @param [Integer] x the X coordinate, in window coordinates
  # @param [Integer] y the Y coordinate, in window coordinates
  def dom_node_at(x, y)
    result = @rpc.call 'DOM.getNodeForLocation', x: x.to_i, y: y.to_i
    dom_node result['nodeId']
  end

  # @private Called by the Client constructor to set up unsupported DOM data.
  def initialize_dom_unstable
  end
end  # module WebkitRemote::Client::Dom

initializer :initialize_dom_unstable

# Unstable cached information about a DOM node.
class DomNode
  # This node's box model information.
  #
  # @return [WebkitRemote::Client::BoxModel] the node's box model layout
  def box_model
    @box_model ||= box_model!
  end

  # Retrieves this node's box model, bypassing the cache.
  #
  # @return [WebkitRemote::Client::BoxModel] the node's box model layout
  def box_model!
    result = @client.rpc.call 'DOM.getBoxModel', nodeId: @remote_id
    WebkitRemote::Client::DomBoxModel.new result['model']
  end

  # Causes this node to receive the input focus.
  #
  # @return [WebkitRemote::Client] self
  def focus
    @client.rpc.call 'DOM.focus', nodeId: @remote_id
    self
  end

  # @private Called by the DomNode constructor.
  def initialize_unstable
    @box_model = nil
  end
  initializer :initialize_unstable
end  # class WebkitRemote::Client::DomNode

# Box model layout information for an element.
class DomBoxModel
  # @return [DomQuad] the margin's boundary
  attr_reader :margin
  # @return [DomQuad] the border's boundary
  attr_reader :border
  # @return [DomQuad] the padding's boundary
  attr_reader :padding
  # @return [DomQuad] the content's boundary
  attr_reader :content

  # @return [Number] the box's width
  attr_reader :width
  # @return [Number] the box's height
  attr_reader :height

  # Wraps raw box model data received via a RPC call.
  #
  # @param [Hash<Symbol, Object>] raw_box_model a BoxModel instance, according
  #     to the Webkit remote debugging protocol; this is the return value of a
  #     'DOM.getBoxModel' call
  def initialize(raw_box_model)
    @width = raw_box_model['width']
    @height = raw_box_model['height']
    @margin = WebkitRemote::Client::DomQuad.new raw_box_model['margin']
    @border = WebkitRemote::Client::DomQuad.new raw_box_model['border']
    @padding = WebkitRemote::Client::DomQuad.new raw_box_model['padding']
    @content = WebkitRemote::Client::DomQuad.new raw_box_model['content']
  end
end  # class WebkitRemote::Client::DomBoxModel

# Coordinates for 4 points that make up a box's boundary.
class DomQuad
  # @return [Array<Number>] x coordinates for the 4 points, in clockwise order
  attr_reader :x

  # @return [Array<Number>] y coordinates for the 4 points, in clockwise order
  attr_reader :y

  # Wraps raw box model data received via a RPC call.
  #
  # @param [Array<Number>] raw_quad a Quad instance, according to the Webkit
  #     remote debugging protocol
  def initialize(raw_quad)
    @x = [raw_quad[0], raw_quad[2], raw_quad[4], raw_quad[6]].freeze
    @y = [raw_quad[1], raw_quad[3], raw_quad[5], raw_quad[7]].freeze
  end
end  # class WebKitRemote::Client::DomQuad

end  # namespace WebkitRemote::Client

end  # namespace WebkitRemote
