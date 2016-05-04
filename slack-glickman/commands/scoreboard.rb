module SlackGlickman
  module Commands
    class Scoreboard < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":mega: :#{statmoji}:" do |client, data, _match|
          query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
          query_params.status = 'in_progress'

          games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

          in_progress_scores = games.map { |game| scoreline_for(game) }

          query_params.status = 'ended'
          query_params.since = '1 day ago'

          games = const_get("Stattleship::#{sport.capitalize}Games").fetch(params: query_params)

          ended_scores = games.map { |game| final_scoreline_for(game) }

          if in_progress_scores == []
            scores = (in_progress_scores + ended_scores).join("\n")
            send_message client, data, ":tv: Nothing on yet\n #{scores}"
          else
            scores = in_progress_scores.join("\n")
            send_message client, data, ":mega: Here's your latest :#{statmoji}: scores! \n #{scores}"
          end
        end

        def self.ahead(game)
          if game.home_team_score == game.away_team_score
            "It's tied in #{game.city}."
          elsif game.home_team_score > game.away_team_score
            "#{game.home_team_name} up in #{game.city} by #{game.home_team_score - game.away_team_score}."
          else
            "#{game.away_team_name} up in #{game.city} by #{game.away_team_score - game.home_team_score}."
          end
        end

        def self.scoreline_for(game)
          "#{game.scoreline} on #{game.started_at.strftime('%A')}. #{ahead(game)}"
        end

        def self.won_by(game)
          if game.home_team_score == game.away_team_score
            "It's tied."
          elsif game.home_team_score > game.away_team_score
            "#{game.home_team_name} won by #{game.home_team_score - game.away_team_score}."
          else
            "#{game.away_team_name} won by #{game.away_team_score - game.home_team_score}."
          end
        end

        def self.final_scoreline_for(game)
          "#{game.scoreline} on #{game.started_at.strftime('%A')}. #{won_by(game)}"
        end
      end
    end
  end
end
