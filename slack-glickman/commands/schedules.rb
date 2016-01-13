module SlackGlickman
  module Basketball
    module Commands
      class Schedules < SlackRubyBot::Commands::Base

        SlackGlickman::App.instance.teamoji.each do |sportmoji|
          sport = sportmoji['sport']
          statmoji = sportmoji['emoji']

          sportmoji['teams'].each do |team|
            teamoji = team['emoji']['default']

            command ":calendar: #{teamoji} #{statmoji}" do |client, data, _match|

              query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
              query_params.status = 'upcoming'
              query_params.team_id = team['slug']

              if sport == 'football' then
                query_params.interval_type = 'wildcard'
              end

              games = const_get("Stattleship::#{sport.capitalize}Games").
                        fetch(params: query_params).
                        last(10).
                        reverse

              games = games.map { |game| "#{game.name} in #{game.city}" }

              if games == []
                send_message client, data.channel, ":calendar: No #{statmoji} #{teamoji} games today."
              else
                games = games.join("\n")
                send_message client, data.channel, ":calendar: Upcoming #{statmoji} #{teamoji} games! \n #{games}"
              end
            end
          end
        end

        ['basketball', 'football', 'hockey'].each do |sport|

          statmoji = if sport == 'hockey'
                       'ice_hockey_stick_and_puck'
                      else
                        sport
                      end

          command ":calendar: :#{statmoji}:" do |client, data, _match|
            query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
            query_params.status = 'upcoming'
            query_params.on = 'today'

            if statmoji == 'football' then
              query_params.interval_type = 'wildcard'
            end

            games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

            games = games.map { |game| "#{game.name} in #{game.city}" }

            if games == []
              send_message client, data.channel, ":calendar: No :#{statmoji}: games today."
            else
              games = games.join("\n")
              send_message client, data.channel, ":calendar: Today's :#{statmoji}: games! \n #{games}"
            end
          end
        end
      end
    end
  end
end
