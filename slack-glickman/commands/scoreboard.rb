module SlackGlickman
  module Commands
    class Scoreboard < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":mega: :#{statmoji}:" do |client, data, _match|
          query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
          query_params.status = 'in_progress'

          games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

          in_progress_scores = games.map { |game| "#{game.scoreline} in #{game.city}" }

          query_params.status = 'ended'
          query_params.since = '1 day ago'

          games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

          ended_scores = games.map { |game| "#{game.scoreline} on #{game.started_at.strftime('%A')}" }

          if in_progress_scores == []
            scores = (in_progress_scores + ended_scores).join("\n")
            send_message client, data, ":tv: Nothing on yet\n #{scores}"
          else
            scores = in_progress_scores.join("\n")
            send_message client, data, ":mega: Here's your latest :#{statmoji}: scores! \n #{scores}"
          end
        end
      end
    end
  end
end
