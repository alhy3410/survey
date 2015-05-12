require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("./lib/question")
require("./lib/survey")
also_reload("lib/**/*.rb")
require("pg")
require('pry')

get('/') do
  erb(:index)
end

get('/admin') do
  @surveys = Survey.all()
  erb(:adminindex)
end

post('/admin') do
  survey_name = params.fetch('survey_name')
  survey = Survey.new(:survey_name => survey_name)
  survey.save()
  @surveys = Survey.all()
  erb(:adminindex)
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

patch("/surveys/:id/list_questions") do
  survey_name = params.fetch("survey_name")
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.update({:survey_name => survey_name})
  erb(:survey_questions_list)
end

delete("/surveys/:id/list_questions") do
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.delete()
  @surveys = Survey.all
  erb(:adminindex)
end

get('/users/list_surveys') do
  @surveys = Survey.all
  erb(:user_survey_list)
end

get('/user/:id/survey_questions_list') do
  @survey = Survey.find(params.fetch('id').to_i())
  erb(:user_survey_questions_list)
end

post('/user/:id/survey_questions_list') do
  answer = params.fetch('answer')
  @survey = Survey.find(params.fetch('id').to_i())
  question_id = params.fetch('question_id').to_i()
  @answered_question = Question.find(question_id)
  @answered_question.update({:answer => answer})
  erb(:user_survey_questions_list)
end
