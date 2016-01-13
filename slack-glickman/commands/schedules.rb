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
              games = schedule(sport: sport,
                               status: 'upcoming',
                               team_id: team['slug'],
                               count: 10)

              games = games.map { |game| "#{game.name} in #{game.city}" }

              if games == []
                send_message client, data.channel, ":calendar: No #{teamoji} #{statmoji} games today."
              else
                games = games.join("\n")
                send_message client, data.channel, ":calendar: Upcoming #{teamoji} #{statmoji} games! \n #{games}"
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

            games = schedule(sport: statmoji, status: 'upcoming', on: 'today')
            games = games.map { |game| "#{game.name} in #{game.city}" }

            if games == []
              send_message client, data.channel, ":calendar: No :#{statmoji}: games today."
            else
              games = games.join("\n")
              send_message client, data.channel, ":calendar: Today's :#{statmoji}: games! \n #{games}"
            end
          end
        end

        def self.schedule(sport: 'basketball', status: 'upcoming', team_id: nil, on: nil, count: 1)
          query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
          query_params.status = status
          query_params.team_id = team_id
          query_params.on = on

          if sport == 'football' then
            query_params.interval_type = 'wildcard'
          end

          const_get("Stattleship::#{sport.capitalize}Games").
                    fetch(params: query_params).
                    last(count).
                    reverse
        end
      end
    end
  end
end
