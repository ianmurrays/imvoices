class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Checks if the request has been authorized and 
  # creates a @current_user variable with the authenticated
  # user.
  def authorize! 
    authorization = request.headers['HTTP_AUTHORIZATION']

    if authorization
      method, jwt = authorization.split(' ')
      decoded_jwt = JWT.decode(jwt, Figaro.env.jwt_secret)

      # Find the user if there is any
      user = User.find(decoded_jwt["user_id"])

      if user
        # All good here
        @current_user = user
        return
      end
    end

    head :unauthorized
  rescue JWT::DecodeError => e # Thrown if the secret is incorrect
    head :unauthorized
  end

  # Serve the Angular app
  def angular
    render nothing: true, layout: true
  end
end
