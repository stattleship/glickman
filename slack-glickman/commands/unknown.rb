module SlackRubyBot
  module Commands
    class Unknown < Base
      match(/^(?<bot>\S*)[\s]*(?<expression>.*)$/)

      def self.call(client, data, _match)
        send_message client, data.channel, "Sorry <@#{data.user}>, Whoops!", gif: 'sports'
      end
    end
  end
end
