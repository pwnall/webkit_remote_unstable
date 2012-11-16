module WebkitRemote

class Client

# Unstable API for the Page domain.
module Page
  # Checks if the debugger can override the browser's device metrics.
  #
  # @return [Boolean] true if WebkitRemote::Client::Page#device_metrics= can be
  #     successfully called
  def can_set_device_metrics?
    response = @rpc.call 'Page.canOverrideDeviceMetrics'
    !!response['result']
  end

  # Overrides the values of device screen dimensions.
  #
  # This changes the properties of window.screen and the results of CSS media
  # queries involving "device-width" and "device-height".
  #
  # @param [Hash<Symbol, Object>] new_device_metrics overridden attributes
  # @option new_device_metrics [Integer] width override for window.screen.width
  #     and window.innerWidth
  # @option new_device_metrics [Integer] height override for
  #     window.screen.height and window.innerHeight
  # @option new_device_metrics [Number] font_scale override for the font scale
  #     factor value
  # @option new_device_metrics [Boolean] fit_window true if views that exceed
  #     the browser window area should be scaled to fit
  #
  # @return [Hash<Symbol, Object>] new_device_metrics
  def device_metrics=(new_device_metrics)
    new_device_metrics = {
      width: new_device_metrics[:width] || nil,
      height: new_device_metrics[:height] || nil,
      font_scale: new_device_metrics[:font_scale] || nil,
      fit_window: new_device_metrics[:fit_window] || false,
    }.freeze
    @rpc.call 'Page.setDeviceMetricsOverride',
              width: new_device_metrics[:width] || 0,
              height: new_device_metrics[:height] || 0,
              fontScaleFactor: new_device_metrics[:font_scale] || 1,
              fitWindow: new_device_metrics[:fit_window] || false
    @device_metrics = new_device_metrics
    new_device_metrics
  end

  # @private Called by the Client constructor to set up unsupported Page data.
  def initialize_page_unstable
    @device_metrics = {}
  end

  # @return [Hash<Symbol, Object>] overridden device metrics; see
  #     WebkitRemote::Client::Page#device_metrics= for details
  attr_reader :device_metrics
end  # module WebkitRemote::Client::Page

initializer :initialize_page_unstable

end  # namespace WebkitRemote::Client

end  # namespace WebkitRemote

