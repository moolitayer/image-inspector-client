# image_inspector_client
a ruby client for [image-inspector](https://github.com/simon3z/image-inspector)

## installing gem
TBD

## usage
```ruby
require 'image_inspector_client'
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
