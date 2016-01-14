 module SlackRubyBot
  module Commands
    class Tips < SlackGlickman::Commands::BaseCommand
      command ":bulb:" do |client, data, _match|
        send_message client, data, ":bulb: ProTip! coming soon"
      end
    end
  end
end
