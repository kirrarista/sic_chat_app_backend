class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User"

  validates :content, presence: true
  validates :sender_role, presence: true, inclusion: { in: %w[initiator expert] }

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.is_read = false if is_read.nil?
  end
end
