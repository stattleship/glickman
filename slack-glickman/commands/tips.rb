 module SlackRubyBot
  module Commands
    class Tips < Base
      match(':bulb:')

      def self.call(client, data, _match)
        send_message client, data.channel, ":bulb: ProTip!"
      end
    end
  end
end
