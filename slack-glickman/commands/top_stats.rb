module SlackGlickman
  module Commands
    class TopStats < SlackRubyBot::Commands::Base
      command ":rain_cloud:" do |client, data, _match|
        query_params = Stattleship::Params::BasketballTopStatsParams.new
        query_params.type = 'basketball_offensive_stat'
        query_params.stat = 'field_goals_made'
        query_params.place = 3

        leaders = Stattleship::BasketballTopStats.fetch(params: query_params).map(&:to_sentence).join("\n")

        send_message client, data.channel, ":rain_cloud: Make it rain! \n #{leaders}"
      end

      command ":thunder_cloud_and_rain:" do |client, data, _match|
        query_params = Stattleship::Params::BasketballTopStatsParams.new
        query_params.type = 'basketball_offensive_stat'
        query_params.stat = 'three_pointers_made'
        query_params.place = 3

        leaders = Stattleship::BasketballTopStats.fetch(params: query_params).map(&:to_sentence).join("\n")

        send_message client, data.channel, ":thunder_cloud_and_rain: It's raining threes! \n #{leaders}"
      end
    end
  end
end
