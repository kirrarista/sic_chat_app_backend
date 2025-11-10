class User < ApplicationRecord
  has_secure_password
  has_one :expert_profile, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.present? }

  after_create :create_expert_profile
end
