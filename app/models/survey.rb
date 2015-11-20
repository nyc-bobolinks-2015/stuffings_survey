class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :choices, through: :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user
  # Remember to create a migration!
end
