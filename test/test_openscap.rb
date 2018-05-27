require 'common'

# Tests for fetch_oscap_arf call
class TestOpenscap < MiniTest::Test
  def test_openscap_happy_flow
    stub_request(:get, %r{/openscap}).to_return(
      body: open_test_file('openscap.xml'),
      status: 200
    )

    md = ImageInspectorClient::Client
         .new('http://localhost:8080', 'v1')
         .fetch_oscap_arf

    assert_equal(File.read('test/xml/openscap.xml'), md)

    assert_requested(
      :get,
      'http://localhost:8080/api/v1/openscap',
      times: 1
    )
  end

  def test_openscap_empty_body
    stub_request(:get, %r{/openscap}).to_return(
      body: '',
      status: 200
    )

    md = ImageInspectorClient::Client
         .new('http://localhost:8080', 'v1')
         .fetch_oscap_arf

    assert_equal('', md)

    assert_requested(
      :get,
      'http://localhost:8080/api/v1/openscap',
      times: 1
    )
  end

  def test_openscap_404
    stub_request(:get, %r{/openscap}).to_return(
      body: 'Openscap option was not chosen',
      status: 404
    )

    e = assert_raises(ImageInspectorClient::InspectorClientException) do
      ImageInspectorClient::Client
        .new('http://localhost:8080', 'v1')
        .fetch_oscap_arf
    end

    assert_equal(404, e.error_code)
    assert_match(/Openscap option was not chosen/, e.message)

    assert_requested(
      :get,
      'http://localhost:8080/api/v1/openscap',
      times: 1
    )
  end
end
