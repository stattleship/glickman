module SlackGlickman
  module Commands
    class GameLogs < SlackGlickman::Commands::BaseCommand

      ['basketball', 'football', 'hockey'].each do |sport|

        statmoji = if sport == 'hockey'
                     'ice_hockey_stick_and_puck'
                    else
                      sport
                    end

        command ":#{statmoji}: :game_die:" do |client, data, match|
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

          if statmoji == 'football' then
            query_params.interval_type = 'divisionalplayoffs'
          end

          game_logs = const_get("Stattleship::#{sport.capitalize}GameLogs").fetch(params: query_params)

          msg = game_logs.sample.to_sentence

          send_message client, data, ":#{statmoji}: :game_die: #{msg}"
        end
      end

      ['basketball', 'football', 'hockey'].each do |sport|

        statmoji = if sport == 'hockey'
                     'ice_hockey_stick_and_puck'
                    else
                      sport
                    end

        command ":#{statmoji}:" do |client, data, match|
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

          if statmoji == 'football' then
            query_params.interval_type = 'divisionalplayoffs'
          end

          game_logs = const_get("Stattleship::#{sport.capitalize}GameLogs").fetch(params: query_params)

          msg = game_logs.last.to_sentence

          send_message client, data, ":#{statmoji}: #{msg}"
        end
      end

      command ':tom:' do |client, data, _match|

        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-tom-brady'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        msg = game_logs.sample.to_sentence

        send_message client, data, ":tom: #{msg}"
      end

      command ':gronk:' do |client, data, _match|

        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-rob-gronkowski'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        msg = game_logs.sample.to_sentence

        send_message client, data, ":gronk: #{msg}"
      end
    end
  end
end
