module SlackGlickman
  module Basketball
    module Commands
      class Players < SlackRubyBot::Commands::Base
        command ":four_leaf_clover: :basketball:" do |client, data, _match|
          send_message client, data.channel, player_for_team(team_id: 'nba-bos',
                                                             sport: 'basketball')
        end

        command ":statue_of_liberty: :basketball:" do |client, data, _match|
          send_message client, data.channel, player_for_team(team_id: 'nba-phi',
                                                             sport: 'basketball')
        end

        command ":bear: :basketball:" do |client, data, _match|
          send_message client, data.channel, player_for_team(team_id: 'nba-mem',
                                                             sport: 'basketball')
        end

        command ":bear: :football:" do |client, data, _match|
          send_message client, data.channel, player_for_team(team_id: 'nfl-chi',
                                                             sport: 'football')
        end

        command ":bear: :ice_hockey_stick_and_puck:" do |client, data, _match|
          send_message client, data.channel, player_for_team(team_id: 'nhl-bos',
                                                             sport: 'hockey')
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
end
