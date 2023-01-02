class RegistrationsController < Devise::RegistrationsController

    def create
     
if params["user"].present? && params["payments"].present?

    build_resource(sign_up_params)
    resource.class.transaction do
    resource.save    
    yield resource if block_given?
    
    if resource.persisted?
    @payment = Payment.new({ email: params["user"]["email"],
    token: params[:payments]["token"], amount: params[:payments]["amt"].to_i , package: params[:payments]["pkg"] , user_id: resource.id })
    flash[:error] = "Please check registration errors" unless @payment.valid?
    begin
    @payment.process_payment
    @payment.save
    #    @package = Package.create({amount: params["packages"]["amt"].to_i , package: params[:packages]["pkg"] , user_id: resource.id})
    rescue Exception => e
    flash[:error] = e.message
    resource.destroy
    puts 'Payment failed'
    render :new and return
    end
    
    if resource.active_for_authentication?
    set_flash_message :notice, :signed_up if is_flashing_format?
    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
    else
    set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
    expire_data_after_sign_in!
    respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
    else
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
    end
    end

else
   resource = User.new(sign_up_params)
   if resource.save
        session[:user_id] = resource.id
        redirect_to landpage_path(resource)
   end
end
    end
    
    def free_signup  
        @user = User.new    
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up).push(:payments)
        # params.require(:signup).permit(:email, :password, :password_confirmation , packages: [:amount, :package] , payments: [:card_cvv , :card_expires_month , :card_expires_year , :card_number] ) 
    end
   
    end