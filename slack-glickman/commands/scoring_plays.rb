module SlackGlickman
  module Commands
    class ScoringPlays < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":tada: #{team['emoji']['slack']} #{sport['emoji']}" do |client, data, _match|
            send_message client, data, penalties_for_team(team_id: team['slug'],
                                                       sport: sport['sport'])
          end
        end
      end

      def self.penalties_for_team(team_id:, sport:)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}ScoringPlaysParams").new
        query_params.team_id = team_id
        query_params.since = '1 week ago'

        scoring_plays = const_get("Stattleship::#{sport.capitalize}ScoringPlays").fetch(params: query_params).
                          take(5)

        msg = scoring_plays.map(&:to_sentence).join("\n")

        caption = if sport == 'hockey'
                    'Goals scored!'
                  else
                    'Scoring!'
                  end

        ":tada: #{caption}\n#{msg}"
      end
    end
  end
end
