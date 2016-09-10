require 'net/http'
require 'json'

class PriceFetcher
  def get_usd
    url = 'https://www.cryptonator.com/api/full/btc-usd'
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)["ticker"]["markets"].map do |market|
      [market["market"], ["$" + market["price"].to_i.to_s]]
    end.to_h
  end

  def get_gbp
    url = 'https://www.cryptonator.com/api/full/btc-gbp'
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)["ticker"]["markets"].map do |market|
      [market["market"], ["£" + market["price"].to_i.to_s]]
    end.to_h
  end

  def combine_currencies
    get_usd.merge(get_gbp) do |market, usd, gbp|
      usd + gbp
    end
  end
end
