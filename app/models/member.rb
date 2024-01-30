class Member < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :avatar
  has_many :opportunities

  enum :gender, [:male, :female]
  enum :role, [:doctor, :patient]
end
