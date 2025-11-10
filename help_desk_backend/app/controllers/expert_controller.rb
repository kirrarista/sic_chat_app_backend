class ExpertController < ApplicationController
  before_action :authenticate_user!

  # GET /expert/queue
  def queue
    waiting_conversations = Conversation.where(status: "waiting", assigned_expert_id: nil)
                                       .order(created_at: :asc)

    assigned_conversations = Conversation.where(assigned_expert_id: current_user.id)
                                        .where.not(status: "waiting")
                                        .order(updated_at: :desc)

    render json: {
      waitingConversations: waiting_conversations.map { |conv| conversation_json(conv) },
      assignedConversations: assigned_conversations.map { |conv| conversation_json(conv) }
    }
  end

  # POST /expert/conversations/:conversation_id/claim
  def claim
    conversation = Conversation.find_by(id: params[:conversation_id])

    unless conversation
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    if conversation.assigned_expert_id.present?
      render json: { error: "Conversation is already assigned to an expert" }, status: :unprocessable_entity
      return
    end

    conversation.update!(
      assigned_expert: current_user,
      status: "active"
    )

    ExpertAssignment.create!(
      conversation: conversation,
      expert: current_user,
      status: "active",
      assigned_at: Time.current
    )

    render json: { success: true }, status: :ok
  end

  # POST /expert/conversations/:conversation_id/unclaim
  def unclaim
    conversation = Conversation.find_by(id: params[:conversation_id])

    unless conversation
      render json: { error: "Conversation not found" }, status: :not_found
      return
    end

    unless conversation.assigned_expert_id == current_user.id
      render json: { error: "You are not assigned to this conversation" }, status: :forbidden
      return
    end

    conversation.update!(
      assigned_expert: nil,
      status: "waiting"
    )

    assignment = ExpertAssignment.find_by(
      conversation: conversation,
      expert: current_user,
      status: "active"
    )
    assignment&.update!(status: "resolved", resolved_at: Time.current)

    render json: { success: true }, status: :ok
  end

  # GET /expert/profile
  def profile
    expert_profile = current_user.expert_profile

    unless expert_profile
      render json: { error: "Expert profile not found" }, status: :not_found
      return
    end

    render json: {
      id: expert_profile.id.to_s,
      userId: expert_profile.user_id.to_s,
      bio: expert_profile.bio,
      knowledgeBaseLinks: expert_profile.knowledge_base_links || [],
      createdAt: expert_profile.created_at.iso8601,
      updatedAt: expert_profile.updated_at.iso8601
    }, status: :ok
  end

  # PUT /expert/profile
  def update_profile
    expert_profile = current_user.expert_profile

    unless expert_profile
      render json: { error: "Expert profile not found" }, status: :not_found
      return
    end

    if expert_profile.update(
      bio: params[:bio],
      knowledge_base_links: params[:knowledgeBaseLinks]
    )
      render json: {
        id: expert_profile.id.to_s,
        userId: expert_profile.user_id.to_s,
        bio: expert_profile.bio,
        knowledgeBaseLinks: expert_profile.knowledge_base_links || [],
        createdAt: expert_profile.created_at.iso8601,
        updatedAt: expert_profile.updated_at.iso8601
      }, status: :ok
    else
      render json: { errors: expert_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /expert/assignments/history
  def assignments_history
    assignments = current_user.expert_assignments.order(assigned_at: :desc)

    render json: assignments.map { |assignment| assignment_json(assignment) }, status: :ok
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

  def assignment_json(assignment)
    {
      id: assignment.id.to_s,
      conversationId: assignment.conversation_id.to_s,
      expertId: assignment.expert_id.to_s,
      status: assignment.status,
      assignedAt: assignment.assigned_at.iso8601,
      resolvedAt: assignment.resolved_at&.iso8601,
      rating: assignment.rating
    }
  end
end
