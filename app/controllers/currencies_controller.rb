class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_symbols = @parsed_data.fetch("symbols").keys
    render( {:template => "currency_templates/step_one.html.erb"})
  end
  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_symbols = @parsed_data.fetch("symbols").keys
    @from_symbol = params.fetch("from_currency")
    render( {:template => "currency_templates/step_two.html.erb"})
  end
  def convert
    @from_symbol = params.fetch("from_currency")
    @to_symbol = params.fetch("to_currency")
    @raw_data = open("https://api.exchangerate.host/convert?from="+@from_symbol+"&to="+@to_symbol).read
    @result = JSON.parse(@raw_data).fetch("info").fetch("rate")
    render( {:template => "currency_templates/convert.html.erb"})
  end
end
