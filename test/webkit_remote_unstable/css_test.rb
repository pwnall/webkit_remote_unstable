require File.expand_path('../helper.rb', File.dirname(__FILE__))

describe WebkitRemote::Client::Css do
  before :all do
    @client = WebkitRemote.local port: 9669
    @client.page_events = true
    @client.navigate_to fixture_url(:css)
    @client.wait_for type: WebkitRemote::Event::PageLoaded
  end
  after :all do
    @client.close
  end

  describe 'without css events enabled' do
    before :each do
      @client.css_events = false
    end

    it 'cannot wait for CSS events' do
      lambda {
        @client.wait_for type: WebkitRemote::Event::MediaQueryResultChanged
      }.must_raise ArgumentError
    end

    describe 'DomNode#computed_style' do
      before :each do
        @node = @client.dom_root.query_selector 'h1'
        @style = @node.computed_style
      end

      it 'gives computed values' do
        @style[:font_size].must_equal '24px'
        @style[:line_height].must_equal '28px'
        @style[:color].must_equal 'rgb(255, 0, 0)'
      end
    end
  end

  describe 'with CSS events enabled' do
    before :each do
      @client.css_events = true
      @client.device_metrics = { width: 512, height: 480, fit_window: false }
      @events = @client.wait_for(
          type: WebkitRemote::Event::MediaQueryResultChanged)
    end

    it 'receives MediaQueryResultChanged events' do
      @events.last.must_be_kind_of WebkitRemote::Event::MediaQueryResultChanged
    end

    describe 'DomNode#computed_style' do
      before :each do
        @node = @client.dom_root.query_selector 'h1'
        @style = @node.computed_style
      end

      it 'gives computed values' do
        @style[:color].must_equal 'rgb(0, 0, 0)'
        @style[:width].must_equal '256px'
        @style[:height].must_equal '240px'
      end
    end
  end
end

