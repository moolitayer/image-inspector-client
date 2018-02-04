require 'common'

# Tests for rest-client return values
class TestRestClient < MiniTest::Test
  def test_metadata_404_plaintext
    stub_request(:get, %r{/metadata}).to_return(
      body: 'No Metadata Given',
      status: 404
    )

    e = assert_raises(ImageInspectorClient::InspectorClientException) do
      ImageInspectorClient::Client
        .new('http://localhost:8080', 'v1')
        .fetch_metadata
    end

    assert_equal(404, e.error_code)
    assert_equal('No Metadata Given', e.message)
  end

  def test_metadata_404_json
    stub_request(:get, %r{/metadata}).to_return(
      body: '{"message": "No Metadata Given"}',
      status: 404
    )

    e = assert_raises(ImageInspectorClient::InspectorClientException) do
      ImageInspectorClient::Client
        .new('http://localhost:8080', 'v1')
        .fetch_metadata
    end

    assert_equal(404, e.error_code)
    assert_equal('No Metadata Given', e.message)
  end

  def test_metadata_404_empty_body
    stub_request(:get, %r{/metadata}).to_return(
      body: '',
      status: 404
    )

    e = assert_raises(ImageInspectorClient::InspectorClientException) do
      ImageInspectorClient::Client
        .new('http://localhost:8080', 'v1')
        .fetch_metadata
    end

    assert_equal(404, e.error_code)
    assert_equal('', e.message)
  end
end
