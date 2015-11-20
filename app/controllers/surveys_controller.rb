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
  if answer.question == survey.questions.count && answer.save
    redirect('/surveys/:survey_id/statistics')
  elsif answer.save
    redirect("/surveys/#{answer.survey}/questions/#{answer.question + 1}")
  else
    @error = "Please select a valid answer"
    erb :'surveys/show'
  end
end

get '/surveys/:survey_id/statistics'


