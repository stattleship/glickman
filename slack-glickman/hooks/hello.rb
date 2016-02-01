module SlackGlickman
  module Hooks
    module Welcome
      extend SlackRubyBot::Hooks::Base

      def welcome(client, data)
        sport = ['basketball', 'football', 'ice_hockey_stick_and_puck'].sample
        msg = "Are you ready for some :#{sport}:?"
        logger.info msg
      end
    end
  end
end
