class RenewController < ApplicationController

    def renew_form
      @payment = Payment.new
    end
    def renew_pay 
      @payment = Payment.new({ email: params[:payment]["email"],
      token: params[:payment]["token"], amount: params[:payment]["amt"].to_i , package: params[:payment]["pkg"] , user_id: current_user.id })
      @payment.process_payment
     if @payment.save
          redirect_to landpage_path
          flash[:alert] = "your payment has successfully done. You are premium member now "
     end
    end

    private
    def payment_params
       params.require(:payment).permit!
    end
end