module SlackGlickman
  module Commands
    class Playermoji < SlackGlickman::Commands::BaseCommand
      # https://github.com/stattleship/playermoji

      SlackGlickman::App.instance.playermoji.each do |playermoji|
        command "#{playermoji['emoji']}" do |client, data, match|
          player_game_log(client: client,
                          data: data,
                          emoji: match['command'],
                          player_id: playermoji['slug'],
                          sport: playermoji['sport'])

        end
      end

      def self.player_game_log(client:, data:, emoji:, player_id:, sport:)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}GameLogsParams").new

        query_params.player_id = player_id

        game_logs = const_get("Stattleship::#{sport.capitalize}GameLogs").fetch(params: query_params)

        msg = game_logs.sample.to_sentence

        send_message client, data, "#{emoji} #{msg}"
      end
    end
  end
end
