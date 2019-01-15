require "application_responder"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :json

	# protect_from_forgery with: :null_session
    protected

    def authenticate
        email = request.headers["HTTP_EMAIL"]
        token = request.headers["HTTP_TOKEN"]

        if email.present? and token.present?
            unless @user = User.find_by(email: email)
                render json: { errors: "User not found" }, status: :not_found
                return
            else
                if @user.token != token
                    render json: { errors: "Unauthorized"}, status: :unauthorized
                return
                end
            end
        else
            render json: { errors: "Unauthorized"}, status: :unauthorized
        end
    end
end
