require 'common'

# Tests for fetch_metadata call
class TestMetadata < MiniTest::Test
  def test_metadata_v1
    stub_request(:get, %r{/metadata}).to_return(
      body: open_test_file('metadata.json'),
      status: 200
    )

    md = ImageInspectorClient::Client.new('http://localhost:8080', 'v1')
         .fetch_metadata

    assert_instance_of(RecursiveOpenStruct, md)
    assert_equal(md.Id, '85f4e2af80d39fccfa3abd218732bc4fc1711665527c5fdd556fb0ff9139c789')
    assert_equal(md.DockerVersion, '1.8.2')
    assert_equal(md.Architecture, 'amd64')
    assert_equal(
      md.ContainerConfig.Image,
      '48ecf305d2cf7046c1f5f8fcbcd4994403173441d4a7f125b1bb0ceead9de731'
    )

    assert_requested(:get,
                     'http://localhost:8080/api/v1/metadata',
                     times: 1)
  end
end
