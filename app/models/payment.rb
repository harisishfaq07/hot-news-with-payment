class Payment < ApplicationRecord
    attr_accessor :card_number , :card_cvv , :card_expires_month , :card_expires_year , :pkg , :amt 
    belongs_to :user

    def process_payment
        customer = Stripe::Customer.create email: email, card: token
            Stripe::PaymentIntent.create customer: customer.id,
            amount: 5000,
            description: 'Premium',
            currency: 'usd' 
    end

    class << self
        def month_options
            Date::MONTHNAMES.each do |m|
             m
            end
        end
        def year_options
            (Date.today.year .. Date.today.year + 10).to_a
        end
    end
end
