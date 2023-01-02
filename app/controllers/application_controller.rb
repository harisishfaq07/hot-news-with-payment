class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        landpage_path(current_user)
    end

    def verify_payment!
        if current_user.payments.count == 0  && current_user.news.count >= 10
             redirect_to landpage_path
             flash[:alert] = "Your limit has been completed, Please Buy the Premium Package to create publish news "
        end
    end
end
