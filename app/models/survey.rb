class Survey < ActiveRecord::Base
  attr_accessor :stats_for_all_answers
  
  has_many :questions, dependent: :destroy
  has_many :choices, through: :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user


  def stats_nil?
    @stats_for_all_answers == nil
  end

  def set_stats
    @stats_for_all_answers = {}
  end
  
  def number_of_participants
    self.answers.map{|answer| answer.user_id}.uniq.count
  end

  def percent_answered_same(question_id, choice_id)
    set_stats if stats_nil?
    number_of_same_answers = self.answers.where(question_id: question_id, choice_id: choice_id, survey_id: self.id).count
    percent = (number_of_same_answers / number_of_participants.to_f * 100).round(2)
    self.stats_for_all_answers.merge!({question_id => [choice_id, percent]})
  end

  def clear_stats
    stats_for_all_answers.clear
  end

  def end_of_survey?(answer)
    relative_id = answer.question.id - self.questions.first.id + 1
    relative_id == self.questions.count
  end
end