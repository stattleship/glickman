module SlackGlickman
  module Commands
    class Charts < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":chart_with_upwards_trend: :#{statmoji}:" do |client, data, match|
          return

          url = nil

          query_params = const_get("Stattleship::Params::#{sport.capitalize}GameLogsParams").new
          player_name = match['expression'].strip.
                                            gsub('nba-', '').
                                            gsub('nfl-', '').
                                            gsub('nhl-', '').
                                            split(' ').
                                            join('-').
                                            downcase


          player_slug = case sport
                        when 'basketball'
                          "nba-#{player_name}"
                        when 'football'
                          "nfl-#{player_name}"
                        when 'hockey'
                          "nhl-#{player_name}"
                        else
                          player_name
                        end

          query_params.player_id = player_slug

          game_logs = const_get("Stattleship::#{sport.capitalize}GameLogs").fetch(params: query_params)


          if game_logs.size > 0
            # games = game_logs.map(&:game)

            chart_data = {
              x: game_logs.map(&:scoreline),
              y: game_logs.map(&:points)
            }

            player = game_logs.first.player

            chart_args = {
              filename: "#{player_slug}_game_logs",
              fileopt: 'overwrite',
              style: { type: 'scatter' },
              layout: {
                title: "#{player.name} Points"
              },
              world_readable: true
            }

            plotly = PlotLy.new(ENV['PLOTLY_USERNAME'], ENV['PLOTLY_API_KEY'])
            plotly.plot(chart_data, chart_args) do |response|
              url = "#{response['url']}/#{chart_args[:filename]}.png"
            end

            options = {}
            client.say(options.merge(channel: data.channel, text: ":chart_with_upwards_trend: #{url}"))
          else
            msg = 'Nothing to see here'
            send_error client, data, ":#{statmoji}: #{msg}"
          end
        end
      end
    end
  end
end
