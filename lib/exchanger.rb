require_relative './user_input.rb'
require_relative './processor.rb'

class Exchanger
  def exchange
    get_input &&
      process_input &&
      display_result
  end


  private

  attr_reader :base_currency, :amount, :to_currency, :result

  def get_input
    user_input = ::UserInput.new
    @base_currency = user_input.accept('Enter currency you want to convert:')
    @amount = user_input.accept('Enter amount to be converted:')
    @to_currency = user_input.accept('Enter into which currency want to converted:')
  end

  def process_input
    processor = ::Processor.new(base_currency, amount, to_currency)
    @result = processor.process
  end

  def display_result
    p "**********************************************************"
    p "#{base_currency} #{amount} => #{result} #{to_currency}"
    p "**********************************************************"
  end

end
