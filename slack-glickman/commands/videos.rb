module SlackGlickman
  module Commands
    class Videos < SlackGlickman::Commands::BaseCommand
      command ":movie_camera: :four_leaf_clover: :basketball:" do |client, data, _match|
        send_gif(client, data, 'boston celtics')
      end

      command ":movie_camera: :bear: :ice_hockey_stick_and_puck:" do |client, data, _match|
        send_gif(client, data, 'boston bruins')
      end
    end
  end
end
