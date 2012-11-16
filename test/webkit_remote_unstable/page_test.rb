require File.expand_path('../helper.rb', File.dirname(__FILE__))

describe WebkitRemote::Client::Page do
  before :all do
    @client = WebkitRemote.local port: 9669
    @client.page_events = true
    @client.navigate_to fixture_url(:page)
    @client.wait_for type: WebkitRemote::Event::PageLoaded
  end
  after :all do
    @client.close
  end

  describe 'can_set_device_metrics?' do
    it 'returns true in Chrome' do
      @client.can_set_device_metrics?.must_equal true
    end
  end

  describe 'device_metrics=' do
    before :each do
      @client.device_metrics = { width: 512, height: 480, fit_window: true }
    end

    it 'changes window.innerWidth and window.innerHeight' do
      @client.remote_eval('window.innerWidth').must_be_close_to 512, 1
      @client.remote_eval('window.innerHeight').must_be_close_to 480, 1
    end

    it 'changes window.screen.width and window.screen.height' do
      @client.remote_eval('window.screen.width').must_be_close_to 512, 1
      @client.remote_eval('window.screen.height').must_be_close_to 480, 1
    end
  end
end
