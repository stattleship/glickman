module SlackGlickman
  module Commands
    class Injuries < SlackGlickman::Commands::BaseCommand
      ['basketball', 'football', 'hockey'].each do |sport|
        statmoji = if sport == 'hockey'
                     'ice_hockey_stick_and_puck'
                    else
                      sport
                    end
        command ":face_with_head_bandage: :#{statmoji}:" do |client, data, _match|
          msg = fetch_injury(sport: sport)
          send_message client, data, ":face_with_head_bandage: #{msg}"
        end
      end

      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":face_with_head_bandage: #{team['emoji']['default']} #{sport['emoji']}" do |client, data, _match|
            msg = fetch_injury(sport: sport['sport'], team_id: team['slug'])
            send_message client, data, ":face_with_head_bandage: #{team['emoji']['default']} #{sport['emoji']} #{msg}"
          end
        end
      end

      def self.fetch_injury(sport: 'basketball', team_id:)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}InjuriesParams").new
        query_params.team_id = team_id

        injuries = const_get("Stattleship::#{sport.capitalize}Injuries").fetch(params: query_params)

        msg = injuries.sample.note
      end
    end
  end
end
