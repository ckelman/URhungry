class UserParameterSanitizer < Devise::ParameterSanitizer
    private
    def account_update
        default_params.permit(:is_admin,:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
    end
    
end