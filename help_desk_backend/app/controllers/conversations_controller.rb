class ConversationsController < ApplicationController
  before_action :authenticate_user!

  # GET /conversations
  def index
    conversations = Conversation.where(initiator_id: current_user.id)
                                .or(Conversation.where(assigned_expert_id: current_user.id))
                                .order(updated_at: :desc)

    render json: conversations.map { |conv| conversation_json(conv) }
  end

  # GET /conversations/:id
  def show
    conversation = Conversation.find_by(id: params[:id])

    unless conversation
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    unless conversation.initiator_id == current_user.id || conversation.assigned_expert_id == current_user.id
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    render json: conversation_json(conversation)
  end

  # POST /conversations
  def create
    conversation = Conversation.new(
      title: params[:title],
      initiator: current_user
    )

    if conversation.save
      render json: conversation_json(conversation), status: :created
    else
      render json: { errors: conversation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def conversation_json(conversation)
    unread_count = conversation.messages.where(is_read: false)
                                        .where.not(sender_id: current_user.id)
                                        .count

    {
      id: conversation.id.to_s,
      title: conversation.title,
      status: conversation.status,
      questionerId: conversation.initiator_id.to_s,
      questionerUsername: conversation.initiator.username,
      assignedExpertId: conversation.assigned_expert_id&.to_s,
      assignedExpertUsername: conversation.assigned_expert&.username,
      createdAt: conversation.created_at.iso8601,
      updatedAt: conversation.updated_at.iso8601,
      lastMessageAt: conversation.last_message_at&.iso8601,
      unreadCount: unread_count
    }
  end
end
