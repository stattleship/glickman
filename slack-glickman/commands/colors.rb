module SlackGlickman
  module Commands
    class Colors < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sport|
        command ":lower_left_paintbrush: #{sport['emoji']}" do |client, data, _match|
          team_colors = teams(sport: sport['sport']).map { |team| "#{team.name} #{team_hex_colors(team: team)}" }
          options = {}
          client.say(options.merge(channel: data.channel, text: team_colors.join("\n")))
        end
      end

      SlackGlickman::App.instance.teamoji.each do |sportmoji|
        sportmoji['teams'].each do |team|
          sport = sportmoji['sport']
          statmoji = sportmoji['emoji']
          teamoji = team['emoji']['slakc']

          command ":lower_left_paintbrush: #{teamoji} #{statmoji}" do |client, data, _match|
            requested_team = teams(sport: sport).detect { |t| t.slug == team['slug'] }
            team_colors = "#{requested_team.name} #{team_hex_colors(team: requested_team)}"
            options = {}
            client.say(options.merge(channel: data.channel, text: team_colors))
          end
        end
      end

      def self.teams(sport: 'basketball')
        query_params = const_get("Stattleship::Params::#{sport.capitalize}TeamsParams").new
        const_get("Stattleship::#{sport.capitalize}Teams").fetch(params: query_params)
      end

      def self.team_hex_colors(team:)
        team.colors.
         map { |color| "##{color}" }.
         join(' ')
      end
    end
  end
end
