get '/surveys' do
  if logged_in?
    @surveys = Survey.all
    erb :'surveys/index'
  else
    redirect ('/')
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
  survey = Survey.new(user: session[:user_id], title: params[:title], description: params[:description])
  if survey.save
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
    @question = Question.find_by_id(params[:question_id])
    erb :'surveys/show'
  end
end

post '/surveys/:survey_id/questions/:question_id' do
  answer = Answer.new(survey: params[:survey_id], question: params[:question_id], choice: params[:choice_id], user: session[:user_id])
  survey = Survey.find(params[:survey_id])
  if answer.question == survey.questions.count && answer.save #checks if answer is last answer in survey
    stat_for_answer = survey.percent_answered_same(params[:question_id], answer.choice_id)
    survey.stats_for_all_answers << stat_for_answer
    redirect('/surveys/:survey_id/statistics')
  elsif answer.save
    stat_for_answer = survey.percent_answered_same(params[:question_id], answer.choice_id)
    survey.stats_for_all_answers << stat_for_answer
    redirect("/surveys/#{answer.survey}/questions/#{answer.question + 1}")
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


