module SlackGlickman
  module Basketball
    module Commands
      class Injuries < SlackRubyBot::Commands::Base
        ['basketball', 'football', 'hockey'].each do |sport|
          statmoji = if sport == 'hockey'
                       'ice_hockey_stick_and_puck'
                      else
                        sport
                      end

          command ":face_with_head_bandage: :#{statmoji}:" do |client, data, _match|

            query_params = const_get("Stattleship::Params::#{sport.capitalize}InjuriesParams").new

            injuries = const_get("Stattleship::#{sport.capitalize}Injuries").fetch(params: query_params)

            msg = injuries.sample.note

            send_message client, data.channel, ":face_with_head_bandage: #{msg}"
          end
        end
      end
    end
  end
end
