require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :surveys
  has_many :answers, dependent: :destroy

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def has_taken_survey?(survey_id)
    self.answers.find_by(survey_id: survey_id) != nil ? true : false
  end
end
