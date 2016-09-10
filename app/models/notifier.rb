class Notifier
  def notify
    phone_numbers.each do |number|
      send_message(number, format_market_currencies)
    end
  end

  def send_message(phone_number, message)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']

    message = @client.account.messages.create(
        :from => @twilio_number,
        :to => phone_number,
        :body => message,
      )

    puts message.to
  end

  def fetch_market_currencies
    PriceFetcher.new.combine_currencies
  end

  def format_market_currencies
    fetch_market_currencies.map do |market, currencies|
      "#{market}: #{currencies.join(" ")}"
    end.join("\n")
  end

  private

  def phone_numbers
    [ENV['NUMBER_ONE'], ENV['NUMBER_TWO']]
  end
end
