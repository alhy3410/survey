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

get('/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i())
  erb(:survey_questions_list)
end
