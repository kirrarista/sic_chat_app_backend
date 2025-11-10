class ApiController < ApplicationController
  # GET /api/conversations/updates
  def conversations_updates
    user_id = params[:userId]

    unless user_id
      render json: { error: "userId parameter is required" }, status: :bad_request
      return
    end

    user = User.find_by(id: user_id)
    unless user
      render json: { error: "User not found" }, status: :not_found
      return
    end

    # Get conversations where user is initiator or assigned expert
    conversations = Conversation.where(initiator_id: user.id)
                                .or(Conversation.where(assigned_expert_id: user.id))

    # Filter by 'since' timestamp if provided
    if params[:since].present?
      since_time = Time.iso8601(params[:since]) rescue nil
      if since_time
        conversations = conversations.where("updated_at > ?", since_time)
      end
    end

    conversations = conversations.order(updated_at: :desc)

    render json: conversations.map { |conv| conversation_json(conv, user) }
  end

  # GET /api/messages/updates
  def messages_updates
    user_id = params[:userId]

    unless user_id
      render json: { error: "userId parameter is required" }, status: :bad_request
      return
    end

    user = User.find_by(id: user_id)
    unless user
      render json: { error: "User not found" }, status: :not_found
      return
    end

    # Get conversations the user has access to
    conversation_ids = Conversation.where(initiator_id: user.id)
                                   .or(Conversation.where(assigned_expert_id: user.id))
                                   .pluck(:id)

    # Get messages from those conversations
    messages = Message.where(conversation_id: conversation_ids)

    # Filter by 'since' timestamp if provided
    if params[:since].present?
      since_time = Time.iso8601(params[:since]) rescue nil
      if since_time
        messages = messages.where("created_at > ?", since_time)
      end
    end

    messages = messages.order(created_at: :desc)

    render json: messages.map { |message| message_json(message) }
  end

  # GET /api/expert-queue/updates
  def expert_queue_updates
    expert_id = params[:expertId]

    unless expert_id
      render json: { error: "expertId parameter is required" }, status: :bad_request
      return
    end

    expert = User.find_by(id: expert_id)
    unless expert
      render json: { error: "Expert not found" }, status: :not_found
      return
    end

    # Get all waiting conversations (not yet assigned to any expert)
    waiting_conversations = Conversation.where(status: "waiting", assigned_expert_id: nil)

    # Get conversations assigned to this expert
    assigned_conversations = Conversation.where(assigned_expert_id: expert.id)
                                         .where.not(status: "waiting")

    # Filter by 'since' timestamp if provided
    if params[:since].present?
      since_time = Time.iso8601(params[:since]) rescue nil
      if since_time
        waiting_conversations = waiting_conversations.where("updated_at > ?", since_time)
        assigned_conversations = assigned_conversations.where("updated_at > ?", since_time)
      end
    end

    waiting_conversations = waiting_conversations.order(created_at: :asc)
    assigned_conversations = assigned_conversations.order(updated_at: :desc)

    render json: [{
      waitingConversations: waiting_conversations.map { |conv| conversation_json(conv, expert) },
      assignedConversations: assigned_conversations.map { |conv| conversation_json(conv, expert) }
    }]
  end

  private

  def conversation_json(conversation, user)
    # Calculate unread count for the user
    unread_count = conversation.messages.where(is_read: false)
                                        .where.not(sender_id: user.id)
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
