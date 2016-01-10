module SlackGlickman
  module Basketball
    module Commands
      class Venues < SlackRubyBot::Commands::Base
        command ":stadium:" do |client, data, _match|
          send_message client, data.channel, ":stadium: Attendance figures coming soon."
        end
      end
    end
  end
end
