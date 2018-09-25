require_relative './user_input.rb'
require_relative './processor.rb'

#  This inputs and processes & displays result for currency exchange
class Exchanger
  def exchange
    input &&
      process_input &&
      display_result
  end

  private

  attr_reader :base_currency, :amount, :to_currency, :result

  def input
    user_input = ::UserInput.new
    @base_currency = user_input.accept('Enter currency you want to convert:')
    @amount = user_input.accept('Enter amount to be converted:')
    @to_currency = user_input.accept('Enter into which currency to convert:')
  end

  def process_input
    processor = ::Processor.new(base_currency, amount, to_currency)
    @result = processor.process
  end

  def display_result
    p '*' * 50
    p "#{base_currency} #{amount} => #{result} #{to_currency}"
    p '*' * 50
  end
end
