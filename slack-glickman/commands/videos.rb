module SlackGlickman
  module Commands
    class Videos < SlackRubyBot::Commands::Base
      command ":movie_camera: :four_leaf_clover: :basketball:" do |client, data, _match|
        send_gif(client, data.channel, 'boston celtics')
      end

      command ":movie_camera: :bear: :ice_hockey_stick_and_puck:" do |client, data, _match|
        send_gif(client, data.channel, 'boston bruins')
      end
    end
  end
end
