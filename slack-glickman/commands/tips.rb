 module SlackRubyBot
  module Commands
    class Tips < SlackRubyBot::Commands::Base
      command ":bulb:" do |client, data, _match|
        send_message client, data.channel, ":bulb: ProTip! coming soon"
      end
    end
  end
end
