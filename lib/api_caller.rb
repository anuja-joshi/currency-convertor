require 'net/http'
require 'json'

# this handles API calls
class ApiCaller
  def initialize(base_url, query_params)
    @base_url = base_url
    @query_params = query_params
  end

  def get
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end

  private

  attr_reader :base_url, :query_params

  def uri
    uri = URI(base_url)
    uri.query = URI.encode_www_form(query_params)
    uri
  end
end
