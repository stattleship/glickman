module SlackGlickman
  module Commands
    class GameMaps < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App.instance.teamoji.each do |sportmoji|
        sportmoji['teams'].each do |team|
          sport = sportmoji['sport']
          statmoji = sportmoji['emoji']
          teamoji = team['emoji']['slack']

          command ":round_pushpin: #{teamoji} #{statmoji}" do |client, data, _match|
            poly = MapPolygon.new(color: '0xDC143C', geodesic: true)

            map = if ENV['GOOGLE_MAPS_API_KEY']
                    GoogleStaticMap.new(api_key: ENV['GOOGLE_MAPS_API_KEY'])
                  else
                    GoogleStaticMap.new
                  end

            schedule(sport: sport, team_id: team['slug'], status: 'upcoming').each do |game|
              location = MapLocation.new(latitude: game.latitude, longitude: game.longitude)
              poly.points << location
              map.markers << MapMarker.new(color: "0x#{game.home_team.color}",
                                           label: game.home_team.nickname.first,
                                           location: location)
            end

            map.paths << poly

            image_url = map.url('http')
            options = {}
            client.say(options.merge(channel: data.channel, text: ":round_pushpin: #{image_url}"))
          end
        end
      end

      def self.schedule(sport: 'basketball', status: 'ended', team_id:, count: 10)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}GamesParams").new
        query_params.status = status
        query_params.team_id = team_id

        if sport == 'football'
          query_params.since = '3 months ago'
        else
          query_params.since = '2 weeks ago'
        end

        const_get("Stattleship::#{sport.capitalize}Games").
                  fetch(params: query_params).
                  reverse.
                  take(count)
      end
    end
  end
end
