require 'sinatra/base'

module SlackGlickman
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
