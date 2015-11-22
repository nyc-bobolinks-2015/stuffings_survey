require 'pry'

get '/surveys' do
  if !logged_in?
    redirect ('/')
  else
    @surveys = Survey.all
    erb :'surveys/index'
  end
end


get '/surveys/new' do
  if !logged_in?
    redirect('/')
  else
    erb :'surveys/new'
  end
end

post '/surveys' do
  survey = Survey.create(user_id: session[:user_id], title: params[:survey][:title], description: params[:survey][:description])
  params[:survey].delete('title')
  params[:survey].delete('description')
  binding.pry
  params[:survey].each do |key, value|
    if key == "question"
      last_quest = Question.create(survey_id: survey.id, text: value)
    elsif key == "choice"
      Choice.create(question_id: last_quest.id, text: value)
    end
  end
  binding.pry
  if survey.persisted?
    binding.pry
    redirect('/surveys')
  else
    @errors = survey.errors.full_messages
    erb :'surveys/index'
  end
end

get '/surveys/:survey_id/questions/:question_id' do
  if !logged_in?
    redirect('/')
  else
    @survey = Survey.find_by_id(params[:survey_id])
    @question = Question.find_by_id(params[:question_id])
    erb :'surveys/show'
  end
end

post '/surveys/:survey_id/questions/:question_id' do
  choice = Choice.find_by(text: params[:choice])
  answer = Answer.new(survey_id: params[:survey_id], question_id: params[:question_id], choice: choice, user_id: session[:user_id])
  survey = Survey.find(params[:survey_id])
  if answer.question == survey.questions.count && answer.save #checks if answer is last answer in survey
    stat_for_answer = survey.percent_answered_same(params[:question_id], answer.choice_id)
    survey.stats_for_all_answers=(stat_for_answer)
    redirect('/surveys/:survey_id/statistics')
  elsif answer.save
    stat_for_answer = survey.percent_answered_same(params[:question_id], answer.choice_id)
    survey.stats_for_all_answers=(stat_for_answer)
    redirect("/surveys/#{survey.id}/questions/#{params[:question_id].to_i + 1}")
  else
    @error = "Please select a valid answer"
    erb :'surveys/show'
  end
end

get '/surveys/:survey_id/statistics' do
  @survey = Survey.find_by_id(params[:survey_id])
  @stats_for_all_answers = @survey.stats_for_all_answers
  @survey.clear_stats
  erb :'surveys/statistics'
end

get '/surveys/add_question' do
  erb :'surveys/_question', layout: !request.xhr?
end

get '/surveys/add_choice' do
  erb :'surveys/_choice', layout: !request.xhr?
end

