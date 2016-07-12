require 'json'
require 'rest-client'
require 'recursive_open_struct'

# Client for image inspector: https://github.com/simon3z/image-inspector
module ImageInspectorClient
  # module entry point
  class Client
    def initialize(
      uri,
      version = 'v1',
      ssl_options: {
        client_cert: nil,
        client_key:  nil,
        ca_file:     nil,
        cert_store:  nil,
        verify_ssl:  OpenSSL::SSL::VERIFY_PEER
      },
      auth_options: {
        username:          nil,
        password:          nil,
        bearer_token:      nil
      },
      http_proxy_uri:   nil
    )
      @endpoint = URI.parse("#{uri}/api/#{version}")
      @auth_options = auth_options
      @ssl_options = ssl_options
      @http_proxy_uri = http_proxy_uri
      @headers = {}
    end

    def fetch_oscap_arf
      exception_handler do
        RestClient::Resource.new(@endpoint, http_options)['openscap'].get(http_headers).body
      end
    end

    def fetch_metadata
      exception_handler do
        RecursiveOpenStruct.new(
          JSON.parse(
            RestClient::Resource.new(@endpoint, http_options)['metadata'].get(http_headers)
          )
        )
      end
    end

    private

    def exception_handler
      yield
    rescue RestClient::Exception => e
      begin
        json_error_msg = JSON.parse(e.response || '') || {}
      rescue JSON::ParserError
        json_error_msg = {}
      end
      err_message = json_error_msg['message'] || e.response
      raise InspectorClientException.new(e.http_code, err_message)
    end

    def http_options
      {
        ssl_client_cert: @ssl_options[:client_cert],
        ssl_client_key:  @ssl_options[:client_key],
        ssl_ca_file:     @ssl_options[:ca_file],
        ssl_cert_store:  @ssl_options[:cert_store],
        verify_ssl:      @ssl_options[:verify_ssl],
        user:            @auth_options[:username],
        password:        @auth_options[:password],
        proxy:           @http_proxy_uri
      }
    end

    def http_headers
      if @auth_options[:bearer_token]
        {
          Authorization: "Bearer #{@auth_options[:bearer_token]}"
        }
      else
        {}
      end
    end
  end

  # Exception thrown by this module
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
