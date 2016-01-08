module SlackGlickman
  module Basketball
    module Commands
      class Frivolities < SlackRubyBot::Commands::Base
        command ":eggplant:" do |client, data, _match|
          send_gif(client, data.channel, 'brett favre')
        end

        command ":pizza:" do |client, data, _match|
          query_params = Stattleship::Params::FootballGameLogsParams.new

          query_params.player_id = 'nfl-peyton-manning'

          game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

          msg = game_logs.sample.to_sentence

          send_message client, data.channel, ":pizza: #{msg}"
        end
      end
    end
  end
end
