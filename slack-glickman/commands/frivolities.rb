module SlackGlickman
  module Basketball
    module Commands
      class Frivolities < SlackRubyBot::Commands::Base
        command ":eggplant:" do |client, data, _match|
          send_gif(client, data.channel, 'brett favre')
        end
      end
    end
  end
end
