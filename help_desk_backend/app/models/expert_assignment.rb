class ExpertAssignment < ApplicationRecord
  belongs_to :conversation
  belongs_to :expert, class_name: "User"

  validates :status, presence: true, inclusion: { in: %w[active resolved] }
  validates :assigned_at, presence: true

  before_validation :set_assigned_at, on: :create

  private

  def set_assigned_at
    self.assigned_at ||= Time.current
  end
end
