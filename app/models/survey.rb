class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :choices, through: :questions, dependent: :destroy
  has_many :answers, through: :choices, dependent: :destroy
  belongs_to :user

  def number_of_participants
    self.answers.map{|answer| answer.user_id}.uniq.count
  end

  def percent_answered_same(question_id, choice_id)
    number_of_same_answers = self.answers.where(question_id: question_id, choice_id: choice_id, survey_id: self.id).count
    (number_of_same_answers / number_of_participants.to_f * 100).round(2)
  end
end
