require File.expand_path('../helper.rb', File.dirname(__FILE__))

describe WebkitRemote::Client::Dom do
  before :all do
    @client = WebkitRemote.local port: 9669
    @client.page_events = true
    @client.navigate_to fixture_url(:dom)
    @client.wait_for type: WebkitRemote::Event::PageLoaded
  end
  after :all do
    @client.close
  end

  describe 'DomNode#box_model' do
    before do
      @node = @client.dom_root.query_selector '#box_test'
      @box = @node.box_model
    end

    it 'has correct numbers' do
      @box.width.must_equal 89
      @box.height.must_equal 93
      @box.margin.x.must_equal [100, 195, 195, 100]
      @box.margin.y.must_equal [100, 100, 197, 197]
      @box.border.x.must_equal [104, 193, 193, 104]
      @box.border.y.must_equal [101, 101, 194, 194]
      @box.padding.x.must_equal [104, 193, 193, 104]
      @box.padding.y.must_equal [101, 101, 194, 194]
      @box.content.x.must_equal [116, 183, 183, 116]
      @box.content.y.must_equal [110, 110, 183, 183]
    end
  end

  describe '#dom_node_at' do
    before do
      @node = @client.dom_root.query_selector '#box_test'
    end

    it 'identifies the test box correctly' do
      node = @client.dom_node_at 150, 150
      node.must_equal @node
    end
  end
end
