ENV['RACK_ENV'] = 'test'

require('rspec')
require('pry')
require('question')
require('survey')
require('pg')

RSpec.configure do |config|
  config.after(:each) do
    Question.all().each() do |question|
      question.destroy()
    end
  end
end
