module SlackGlickman
  module Commands
    class TopStats < SlackGlickman::Commands::BaseCommand
      command ":rain_cloud:" do |client, data, _match|
        query_params = Stattleship::Params::BasketballTopStatsParams.new
        query_params.type = 'basketball_offensive_stat'
        query_params.stat = 'field_goals_made'
        query_params.place = 3

        leaders = Stattleship::BasketballTopStats.
                   fetch(params: query_params).
                   first(5).
                   map(&:to_sentence).
                   join("\n")

        send_message client, data, ":rain_cloud: Make it rain!\n#{leaders}"
      end

      command ":thunder_cloud_and_rain:" do |client, data, _match|
        query_params = Stattleship::Params::BasketballTopStatsParams.new
        query_params.type = 'basketball_offensive_stat'
        query_params.stat = 'three_pointers_made'
        query_params.place = 3

        leaders = Stattleship::BasketballTopStats.fetch(params: query_params).
                    first(5).
                    map(&:to_sentence).
                    join("\n")

        send_message client, data, ":thunder_cloud_and_rain: It's raining threes!\n#{leaders}"
      end
    end
  end
end
