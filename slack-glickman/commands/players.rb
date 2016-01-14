module SlackGlickman
  module Commands
    class Players < SlackRubyBot::Commands::Base
      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":shirt: #{team['emoji']['default']} #{sport['emoji']}" do |client, data, _match|
            send_message client, data.channel, player_for_team(team_id: team['slug'],
                                                               sport: sport['sport'])
          end
        end
      end

      def self.player_for_team(team_id:, sport:)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}PlayersParams").new
        query_params.team_id = team_id

        player = const_get("Stattleship::#{sport.capitalize}Players").fetch(params: query_params).
                  sample

        msg = player.label

        if player.salary && player.salary > 0
          msg = "#{msg} :moneybag: #{player.humanized_salary}"
        end

        if player.school && player.school != ''
          msg = "#{msg} :school: #{player.school}"
        end

        msg
      end
    end
  end
end
