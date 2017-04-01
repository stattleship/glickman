module SlackGlickman
  module Commands
    class GameLogs < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":#{statmoji}: :game_die:" do |client, data, match|
          query_params = const_get("Stattleship::Params::#{sport.capitalize}GameLogsParams").new
          player_name = match['expression'].strip.
                                            gsub('mlb-', '').
                                            gsub('nba-', '').
                                            gsub('nfl-', '').
                                            gsub('nhl-', '').
                                            split(' ').
                                            join('-').
                                            downcase


          player_slug = case sport
                        when 'baseball'
                          "mlb-#{player_name}"
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
            msg = game_logs.sample.to_sentence
            send_message client, data, ":#{statmoji}: :game_die: #{msg}"
          else
            msg = 'Nothing to see here'
            send_error client, data, ":#{statmoji}: :game_die: #{msg}"
          end
        end
      end

      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":#{statmoji}:" do |client, data, match|
          query_params = const_get("Stattleship::Params::#{sport.capitalize}GameLogsParams").new
          player_name = match['expression'].strip.
                                            gsub('mlb-', '').
                                            gsub('nba-', '').
                                            gsub('nfl-', '').
                                            gsub('nhl-', '').
                                            split(' ').
                                            join('-').
                                            downcase


          player_slug = case sport
                        when 'baseball'
                          "mlb-#{player_name}"
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
            msg = game_logs.max_by { |log| log.game.timestamp }.to_sentence
            send_message client, data, ":#{statmoji}: #{msg}"
          else
            msg = 'Nothing to see here'
            send_error client, data, ":#{statmoji}: #{msg}"
          end
        end
      end

      command ':panda_face:' do |client, data, _match|

        query_params = Stattleship::Params::BaseballGameLogsParams.new

        query_params.player_id = 'mlb-pablo-sandoval'
        query_params.season_id = 'mlb-2015'

        game_logs = Stattleship::BaseballGameLogs.fetch(params: query_params)

        if game_logs.size > 0
          msg = game_logs.sample.to_sentence
          send_message client, data, "Kung Fu :panda_face: #{msg}"
        else
          msg = 'Nothing to see here'
          send_error client, data, "Fung Fu :panda_face: #{msg}"
        end
      end

      command ':tom:' do |client, data, _match|

        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-tom-brady'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        if game_logs.size > 0
          msg = game_logs.sample.to_sentence
          send_message client, data, ":tom: #{msg}"
        else
          msg = 'Nothing to see here'
          send_error client, data, ":tom: #{msg}"
        end
      end

      command ':gronk:' do |client, data, _match|

        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-rob-gronkowski'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        if game_logs.size > 0
          msg = game_logs.sample.to_sentence
          send_message client, data, ":gronk: #{msg}"
        else
          msg = 'Nothing to see here'
          send_error client, data, ":gronk: #{msg}"
        end
      end
    end
  end

end
