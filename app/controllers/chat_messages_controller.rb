class ChatMessagesController < ApplicationController
  before_action :authorize_request

  def index
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
end
