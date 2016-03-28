module SlackGlickman
  module Commands
    class Rankings < SlackGlickman::Commands::BaseCommand
      command ":100: :calendar: :basketball:" do |client, data, _match|
        on = Date.yesterday.to_s

        performance_rankings = rankings(ranking: 'basketball_daily_player_performance_ranking', on: on)

        if performance_rankings
          performances = performance_rankings.map(&:to_sentence).join("\n")
        else
          performances = "Nothing"
        end

        client.say({}.merge(channel: data.channel, text: ":100: :calendar: :basketball: Best Performances for #{on}!\n#{performances}"))
      end

      command ":100: :basketball:" do |client, data, _match|
        performance_rankings = rankings(ranking: 'basketball_season_player_performance_ranking')

        if performance_rankings
          performances = performance_rankings.map(&:to_sentence).join("\n")
        else
          performances = "Nothing"
        end

        client.say({}.merge(channel: data.channel, text: ":100: :calendar: :basketball: Best Game Performances this season!\n#{performances}"))
      end

      def self.rankings(ranking:, on: nil, place: 5)
        query_params = Stattleship::Params::RankingsParams.new
        query_params.ranking = ranking
        query_params.on = on
        query_params.place = place

        Stattleship::Rankings.fetch(params: query_params)
      end
    end
  end
end
