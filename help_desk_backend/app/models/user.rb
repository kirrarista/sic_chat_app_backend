class User < ApplicationRecord
  has_secure_password
  has_one :expert_profile, dependent: :destroy

  # Conversations where this user is the initiator
  has_many :initiated_conversations, class_name: "Conversation", foreign_key: "initiator_id", dependent: :destroy

  # Conversations where this user is the assigned expert
  has_many :assigned_conversations, class_name: "Conversation", foreign_key: "assigned_expert_id", dependent: :nullify

  # Messages sent by this user
  has_many :messages, foreign_key: "sender_id", dependent: :destroy

  # Expert assignments for this user
  has_many :expert_assignments, foreign_key: "expert_id", dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.present? }
end
