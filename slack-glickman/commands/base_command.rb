module SlackGlickman
  module Commands
    class BaseCommand < SlackRubyBot::Commands::Base
      def self.send_message(client, data, text, options = {})
        puts data['user']
        super(client, data.channel, text, options)
      end
    end
  end
end
