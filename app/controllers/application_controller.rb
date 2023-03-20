class ApplicationController < ActionController::API
    before_action :snake_case_params

    # before_action :snake_case_params, :attach_authenticity_token
    helper_method :current_user, :logged_in?
    # rescue_from StandardError, with: :unhandled_error
    # rescue_from ActionController::InvalidAuthenticityToken,
    #   with: :invalid_authenticity_token

    def current_user
        @current_user ||=  User.find_by(session_token: session[:session_token])
      end
      
    def login!(user)
        debugger
        session[:session_token] = user.reset_session_token!
    end
      
    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end


    def logged_in?
        !!current_user
    end
    
    def require_logged_in
        unless current_user
            render json: { message: 'Unauthorized' }, status: :unauthorized 
        end
    end

    private

    def snake_case_params
    params.deep_transform_keys!(&:underscore)
    end
end
