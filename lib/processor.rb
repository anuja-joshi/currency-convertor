require 'yaml'

require_relative './api_caller.rb'

# this processes user input for currency exchange
class Processor
  def initialize(base_currency, amount, to_currency)
    @base_currency = base_currency
    @amount = amount
    @to_currency = to_currency
  end

  def process
    show_wait_msg &&
      fetch_rates &&
      convert
  end

  private

  attr_reader :base_currency, :amount, :to_currency, :rates

  def exchanger_url
    config = YAML.load_file('config/constants.yml')
    config['EXCHANGE_RATE_API_URL']
  end

  def show_wait_msg
    p 'Seat back & relax... we are processing your request!'
  end

  def fetch_rates
    query_params = { base: base_currency, symbols: to_currency }
    api_caller = ::ApiCaller.new(exchanger_url, query_params)
    @fetch_rates ||= api_caller.get
  end

  def convert
    conversion_factor = fetch_rates['rates'][to_currency]
    amount.to_f * conversion_factor
  end
end
