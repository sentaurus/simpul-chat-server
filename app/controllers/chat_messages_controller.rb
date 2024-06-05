class ChatMessagesController < ApplicationController
  before_action :authorize_request

  def show
    @messages = ChatMessage.includes(:user).order(created_at: :asc)
    render json: { messages: @messages }, include: :user
  end

  def create
    @message = @current_user.chat_messages.build(message_params)
    if @message.save
      Pusher.trigger('chat', 'new-message', @message.as_json(include: :user))
      render json: @message, status: :created
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:content)
  end

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
end
