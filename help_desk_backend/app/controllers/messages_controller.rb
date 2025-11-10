class MessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /conversations/:conversation_id/messages
  def index
    conversation = Conversation.find_by(id: params[:conversation_id])

    unless conversation
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    unless conversation.initiator_id == current_user.id || conversation.assigned_expert_id == current_user.id
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    messages = conversation.messages.order(created_at: :asc)

    render json: messages.map { |message| message_json(message) }
  end

  # POST /messages
  def create
    conversation = Conversation.find_by(id: params[:conversationId])

    unless conversation
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    unless conversation.initiator_id == current_user.id || conversation.assigned_expert_id == current_user.id
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    sender_role = if conversation.initiator_id == current_user.id
                    "initiator"
                  else
                    "expert"
                  end

    message = Message.new(
      conversation: conversation,
      sender: current_user,
      sender_role: sender_role,
      content: params[:content]
    )

    if message.save
      conversation.update(last_message_at: message.created_at)

      render json: message_json(message), status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /messages/:id/read
  def mark_as_read
    message = Message.find_by(id: params[:id])

    unless message
      render json: { error: "Message not found" }, status: :not_found
      return
    end

    conversation = message.conversation
    unless conversation.initiator_id == current_user.id || conversation.assigned_expert_id == current_user.id
      render json: { error: "Message not found" }, status: :not_found
      return
    end

    if message.sender_id == current_user.id
      render json: { error: "Cannot mark your own messages as read" }, status: :forbidden
      return
    end

    message.update(is_read: true)

    render json: { success: true }, status: :ok
  end

  private

  def message_json(message)
    {
      id: message.id.to_s,
      conversationId: message.conversation_id.to_s,
      senderId: message.sender_id.to_s,
      senderUsername: message.sender.username,
      senderRole: message.sender_role,
      content: message.content,
      timestamp: message.created_at.iso8601,
      isRead: message.is_read
    }
  end
end
