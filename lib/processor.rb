require 'yaml'

require_relative './api_caller.rb'

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
    config["EXCHANGE_RATE_API_URL"]
  end

  def show_wait_msg
    p "Seat back & relax... we are processing your request!"
  end

  def fetch_rates
    @rates ||= ::ApiCaller.new(exchanger_url, {base: base_currency, symbols: to_currency}).get
  end

  def convert
    conversion_factor = rates["rates"][to_currency]
    amount.to_f * conversion_factor
  end

end
