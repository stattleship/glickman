module SlackGlickman
  module Commands
    class Videos < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":movie_camera: #{team['emoji']['default']} #{sport['emoji']}" do |client, data, _match|
            send_gif(client, data, "#{team['name']} #{team['nickname']}")
          end
        end
      end
    end
  end
end
