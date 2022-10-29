class CurrenciesController < ActionController::Base
  def first_currency
  @raw_data = open("https://api.exchangerate.host/symbols").read
  @parsed_data = JSON.parse(@raw_data)
  
  @symbols_hash = @parsed_data.fetch("symbols")  

  @array_of_symbols= @symbols_hash.keys

    render ({ :template => "currency_templates/step_one.html.erb"})
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
   
    @symbols_hash = @parsed_data.fetch("symbols")  
  
    @array_of_symbols= @symbols_hash.keys
    #params :{"from_currency"=>"ANG"}
    @from_symbol = params.fetch("from_currency").to_sym
  
      render ({ :template => "currency_templates/step_two.html.erb"})
    end

    def view_rate

  
      @from_symbol = params.fetch("from_currency").to_sym
      @to_symbol = params.fetch("to_currency").to_sym

      @raw_data = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_symbol}").read

      #@raw_data = open(api_string).read
      @parsed_data = JSON.parse(@raw_data)

      @rate1 = @parsed_data.fetch("info")
      @rate = @rate1.fetch("rate")
  
      render({:template => "currency_templates/exchange_rate.html.erb"})
    end
end
