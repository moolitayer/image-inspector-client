# image-inspector-client
a ruby client for [image-inspector](https://github.com/simon3z/image-inspector)

## installing gem
gem install image-inspector-client

## usage
```ruby
require 'image-inspector-client'
ImageInspectorClient::Client.new('http://localhost:8080', 'v1')
  .fetch_metadata
  .ContainerConfig
  .Cmd
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
