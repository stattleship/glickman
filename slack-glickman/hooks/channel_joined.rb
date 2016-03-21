module SlackGlickman
  module Hooks
    module ChannelJoined
      extend SlackRubyBot::Hooks::Base

      def channel_joined(client, data)
        sport = SlackGlickman::App::SPORTS.sample
        msg = "Are you ready for some :#{sport}:? \n\n"
        msg = "To find out what I can do, ask me for 'help'."
        logger.info msg
      end
    end
  end
end
