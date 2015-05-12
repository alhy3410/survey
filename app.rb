require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("./lib/question")
require("./lib/survey")
also_reload("lib/**/*.rb")
require("pg")

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/') do
  survey_name = params.fetch('survey_name')
  survey = Survey.new(:survey_name => survey_name)
  survey.save()
  @surveys = Survey.all()
  erb(:index)
end

get('/surveys/:id/add_questions') do
  @survey = Survey.find(params.fetch('id').to_i())
  erb(:add_questions)
end

get('/surveys/:id/list_questions') do
  @survey = Survey.find(params.fetch('id').to_i())
  @questions = Question.find(params.fetch('id').to_i())
  erb(:survey_questions_list)
end

post('/surveys/:id/list_questions') do
  question = params.fetch("survey_question")
  survey_id = params.fetch("id").to_i()
  @survey = Survey.find(survey_id)
  @question = Question.new({:question => question, :survey_id => survey_id})
  @question.save()
  erb(:survey_questions_list)
end
