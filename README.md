Deprecated, upstream development moved to https://github.com/openshift/image-inspector-client-ruby

# image-inspector-client
a ruby client for [image-inspector](https://github.com/openshift/image-inspector)

## installing gem
gem install image-inspector-client

## usage
```ruby
require 'image-inspector-client'
ImageInspectorClient::Client.new('http://localhost:8080', 'v1')
  .fetch_metadata
  .ContainerConfig
  .Cmd


Get OpenSCAP ARF as raw xml:
ImageInspectorClient::Client.new('http://localhost:8080', 'v1')
  .fetch_oscap_arf

```

## building from source
fetch dependencies:
```
bundle install
```
tests:
```
rake test
```
tests and style check:
```
rake test rubocop
```

build and install into $GEM_HOME:
```
rake install
```
