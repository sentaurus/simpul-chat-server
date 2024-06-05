# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  before_action :authorize_request, unless: -> { exclude_authorization? }

  private

  def authorize_request
    @current_user = find_current_user
    render_unauthorized unless @current_user
  end

  def find_current_user
    return nil unless decoded_token
    User.find_by(id: decoded_token['user_id'])
  end

  def decoded_token
    return nil unless token_present?
    token = request.headers['token']
    JWT.decode(token, Rails.application.credentials.jwt_secret)[0] if token
  rescue JWT::DecodeError
    nil
  end

  def token_present?
    request.headers['token'].present? 
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def exclude_authorization?
    # Define conditions under which authorization should be excluded
    # For example, exclude authorization for certain controllers or actions
    # Example:
    controller_name == 'authentication' &&  (action_name == 'login' || action_name == 'register')

  end
end
