module SlackGlickman
  module Commands
    class Results < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sportmoji|
        sport = sportmoji['sport']
        statmoji = sportmoji['emoji']

        sportmoji['teams'].each do |team|
          teamoji = team['emoji']['default']

          command ":no_mouth: #{teamoji} #{statmoji}" do |client, data, _match|
            game_logs = team_game_logs(sport: sport,
                                       status: 'ended',
                                       team_id: team['slug'],
                                       count: 5)

            game_log_mojis = game_logs.map { |game_log| resultmoji(game_log: game_log) }

            results = game_logs.map { |game_log| "#{game_log.game.score} #{game_log.team_outcome.gsub('_', ' ')} vs #{game_log.opponent.nickname}" }

            if game_log_mojis == []
              send_message client, data, ":no_mouth: No #{teamoji} #{statmoji} results."
            else
              game_log_mojis = game_log_mojis.join(' ')
              results = results.join("\n")

              send_message client, data, "#{teamoji} #{statmoji} :point_right: #{game_log_mojis}\n#{results}"
            end
          end
        end
      end

      def self.team_game_logs(sport: 'basketball', status: 'ended', team_id: nil, on: nil, count: 5)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}TeamGameLogsParams").new
        query_params.status = status
        query_params.team_id = team_id
        query_params.on = on

        if sport == 'football' then
          query_params.interval_type = 'superbowl'
        end

        const_get("Stattleship::#{sport.capitalize}TeamGameLogs").
          fetch(params: query_params).
          first(count).
          reverse
      end

      def self.resultmoji(game_log:)
        case game_log.team_outcome
        when 'win'
          ':grinning:'
        when 'loss'
          ':cry:'
        when 'tie'
          ':neutral_face:'
        when 'overtime_loss'
          ':angry:'
        when 'shootout_loss'
          ':weary:'
        else
          ':no_mouth:'
        end
      end
    end
  end
end
