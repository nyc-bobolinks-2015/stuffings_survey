class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :choices, through: :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user

  def number_of_participants
    @number_of_participants = Answers.find_by(survey: self.id).users.all.count
  end
end
