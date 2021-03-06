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

get '/surveys/error' do
  erb :'surveys/error'
end

post '/surveys' do
  @survey = Survey.create(user_id: session[:user_id], title: params[:survey][:title], description: params[:survey][:description])
  erb :'surveys/_data', layout: !request.xhr?
end

get '/surveys/:survey_id/questions/:question_id' do
  if !logged_in?
    redirect('/')
  elsif User.find(session[:user_id]).has_taken_survey?(params[:survey_id])
    redirect('/surveys/error')
  else
    @survey = Survey.find_by_id(params[:survey_id])
    @question = Question.find_by_id(params[:question_id])
    erb :'surveys/show'
  end
end

post '/surveys/:survey_id/questions/:question_id' do
  choice = Choice.find_by(text: params[:choice])
  answer = Answer.new(survey_id: params[:survey_id], question_id: params[:question_id], choice: choice, user_id: session[:user_id])
  @survey = Survey.find(params[:survey_id])
  @survey.answers << answer
  if @survey.end_of_survey?(answer) && answer.save
    @stats = @survey.get_all_stats
    erb :'surveys/statistics', layout: !request.xhr?
  elsif request.xhr? && answer.save
    @question = Question.find_by_id(params[:question_id].to_i + 1)
    erb :'surveys/_next-question', layout: false
  elsif answer.save
    redirect("/surveys/#{@survey.id}/questions/#{params[:question_id].to_i + 1}")
  else
    @error = "Please select a valid answer"
    erb :'surveys/show'
  end
end

get '/surveys/:survey_id/statistics' do
  @survey = Survey.find_by_id(params[:survey_id])
  @stats = @survey.get_all_stats
  erb :'surveys/statistics'
end

post '/surveys/add_question' do
  erb :'surveys/_question', layout: !request.xhr?
end

get '/surveys/add_choice' do
  erb :'surveys/_choice', layout: !request.xhr?
end

post '/surveys/complete_question' do
  info = params[:question]
  s_id = info.pop.to_i
  q_text = info.shift
  question = Question.create(survey_id: s_id, text: q_text)
  info.each do |text|
    Choice.create(question_id: question.id, text: text)
  end
  erb :'surveys/_question', layout: !request.xhr?
end

get '/surveys/complete_survey' do
  info = params[:question]
  s_id = info.pop.to_i
  q_text = info.shift
  question = Question.create(survey_id: s_id, text: q_text)
  info.each do |text|
    Choice.create(question_id: question.id, text: text)
  end
end

get '/surveys/:id' do
  erb :'surveys/show'
end
