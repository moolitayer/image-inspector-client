require 'json'
require 'rest-client'
require 'recursive_open_struct'

# Client for image inspector: https://github.com/simon3z/image-inspector
module ImageInspectorClient
  # module entry point
  class Client
    def initialize(
      uri,
      version = 'v1'
    )
      @endpoint = URI.parse("#{uri}/api/#{version}")
    end

    def fetch_metadata
      handle_exception do
        RecursiveOpenStruct.new(
          JSON.parse(
            RestClient::Resource.new(@endpoint)['metadata'].get
          )
        )
      end
    end

    private

    def handle_exception
      yield
    rescue RestClient::Exception => e
      begin
        json_error_msg = JSON.parse(e.response || '') || {}
      rescue JSON::ParserError
        json_error_msg = {}
      end
      err_message = json_error_msg['message'] || e.message
      raise InspectorClientException.new(e.http_code, err_message)
    end
  end

  # Exception throws by module
  class InspectorClientException < StandardError
    attr_reader :error_code, :message

    def initialize(error_code, message)
      @error_code = error_code
      @message = message
    end

    def to_s
      'HTTP status code ' + @error_code.to_s + ', ' + @message
    end
  end
end
