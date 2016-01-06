module SlackGlickman
  module Basketball
    module Commands
      class StatLeaders < SlackRubyBot::Commands::Base
        command ":doughnut:" do |client, data, _match|
          query_params = Stattleship::Params::HockeyStatLeadersParams.new
          query_params.type = 'hockey_goalie_stat'
          query_params.stat = 'shutouts'
          query_params.place = 3

          leaders = Stattleship::HockeyStatLeaders.fetch(params: query_params).map(&:to_sentence).join("\n")

          send_message client, data.channel, ":doughnut: Shutouts! \n #{leaders}"
        end

        command ':runner:' do |client, data, _match|
          query_params = Stattleship::Params::FootballStatLeadersParams.new
          query_params.type = 'football_rushing_stat'
          query_params.stat = 'rushes_yards'
          query_params.place = 3

          leaders = Stattleship::FootballStatLeaders.fetch(params: query_params).map(&:to_sentence).join("\n")

          send_message client, data.channel, ":runner: Most rushing yards! \n #{leaders}"
        end

        ['basketball', 'football', 'hockey'].each do |sport|

          statmoji = if sport == 'hockey'
                       'ice_hockey_stick_and_puck'
                      else
                        sport
                      end

          command ":top: :#{statmoji}:" do |client, data, match|

            query_params = const_get("Stattleship::Params::#{sport.capitalize}StatLeadersParams").new

            stat_expression = match['expression'].strip.upcase

            case
            when sport == 'basketball' && ['3P', 'FG', 'A', 'P', 'FT'].include?(stat_expression)
              query_params.type = 'basketball_offensive_stat'

              case stat_expression
              when '3P'
                query_params.stat = 'three_pointers_made'
              when 'FT'
                query_params.stat = 'free_throws_made'
              when 'FG'
                query_params.stat = 'field_goals_made'
              when 'A'
                query_params.stat = 'assists'
              when 'P'
                query_params.stat = 'points'
              else
                query_params.stat = 'field_goals_made'
              end

            when sport == 'football' && ['TD'].include?(stat_expression)
              query_params.type = 'football_passing_stat'

              case stat_expression
              when 'TD'
                query_params.stat = 'passes_touchdowns'
              else
                query_params.stat = 'passes_touchdowns'
              end

            when sport == 'hockey' && ['G', 'A', 'S', 'P', 'PPG'].include?(stat_expression)
              query_params.type = 'hockey_offensive_stat'

              case stat_expression
              when 'G'
                query_params.stat = 'goals'
              when 'A'
                query_params.stat = 'assists'
              when 'S'
                query_params.stat = 'shots'
              when 'P'
                query_params.stat = 'points'
              when 'PPG'
                query_params.stat = 'goals_power_play'
              else
                query_params.stat = 'field_goals_made'
              end
            end

            query_params.place = 3

            leaders = const_get("Stattleship::#{sport.capitalize}StatLeaders").fetch(params: query_params)
            leaders = leaders.map(&:to_sentence).join("\n")

            send_message client, data.channel, ":top: #{query_params.stat}! \n #{leaders}"
          end
        end
      end
    end
  end
end
