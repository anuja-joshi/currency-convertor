require 'api_caller.rb'
RSpec.describe ApiCaller do
  context 'Positive test cases' do
    it 'fetches latest currency conversion rates' do
      query_param = { base: 'USD', symbols: 'INR' }
      service = ApiCaller.new('https://api.exchangeratesapi.io/latest',
                              query_param)
      response = service.get
      expect(response).not_to be_nil
    end
  end

  context 'Negative test cases' do
    it 'fails to fetch currency conversion rates when service is down' do
      query_param = { base: 'WRO', symbols: 'INR' }
      service = ApiCaller.new('https://api.exchangeratesapi.io/latest',
                              query_param)
      response = service.get
      error_message = { 'error' => "Base 'WRO' is not supported." }
      expect(response['error']).to eq error_message['error']
    end

    xit 'it uses previous currency exchange rates when failed to fetch' do
    end
  end
end
