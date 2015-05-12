require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("./lib/question")
require("./lib/survey")
also_reload("lib/**/*.rb")
require("pg")

get('/') do
  erb(:index)
end
