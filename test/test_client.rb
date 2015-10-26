require 'common'

# General client tests
class TestClient < MiniTest::Test
  def test_unknown_host
    stub_request(:get, %r{/metadata})
      .to_return(status: 404)

    assert_raises(ImageInspectorClient::InspectorClientException) do
      ImageInspectorClient::Client.new('http://localhost:8080', 'v1')
        .fetch_metadata
    end
  end
end
