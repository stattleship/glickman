module SlackGlickman
  module Commands
    class Penalties < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":package: #{team['emoji']['slack']} #{sport['emoji']}" do |client, data, _match|
            send_message client, data, penalties_for_team(team_id: team['slug'],
                                                       sport: sport['sport'])
          end
        end
      end

      def self.penalties_for_team(team_id:, sport:)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}PenaltiesParams").new
        query_params.team_id = team_id
        query_params.since = '1 week ago'

        if sport == 'football' then
          query_params.interval_type = 'conferencechampionships'
        end

        penalties = const_get("Stattleship::#{sport.capitalize}Penalties").fetch(params: query_params).
                      take(5)

        msg = penalties.map(&:to_sentence).join("\n")

        ":package: Go to box. Feel shame.\n#{msg}"
      end
    end
  end
end
