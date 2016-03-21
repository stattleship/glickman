module SlackGlickman
  module Hooks
    module Welcome
      extend SlackRubyBot::Hooks::Base

      def welcome(client, data)
        sport = SlackGlickman::App::SPORTS.sample
        msg = "Are you ready for some :#{sport}:?"
        logger.info msg
      end
    end
  end
end
