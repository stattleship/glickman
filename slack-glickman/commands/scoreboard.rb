module SlackGlickman
  module Basketball
    module Commands
      class Scoreboard < SlackRubyBot::Commands::Base
        ['basketball', 'football', 'hockey'].each do |sport|

          statmoji = if sport == 'hockey'
                       'ice_hockey_stick_and_puck'
                      else
                        sport
                      end

          command ":mega: :#{statmoji}:" do |client, data, _match|

            query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
            query_params.status = 'in_progress'

            games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

            scores = games.map { |game| "#{game.scoreline} in #{game.city}" }

            if scores == []
              send_message client, data.channel, ':tv: Nothing on yet'
            else
              scores = scores.join("\n")
              send_message client, data.channel, ":mega: Here's your latest :#{statmoji}: scores! \n #{scores}"
            end
          end
        end
      end
    end
  end
end
