module SlackGlickman
  module Commands
    class Injuries < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":face_with_head_bandage: :#{statmoji}:" do |client, data, _match|
          msg = fetch_injury(sport: sport)
          send_message client, data, ":face_with_head_bandage: #{msg}"
        end
      end

      SlackGlickman::App.instance.teamoji.each do |sport|
        sport['teams'].each do |team|
          command ":face_with_head_bandage: #{team['emoji']['slack']} #{sport['emoji']}" do |client, data, _match|
            msg = fetch_injury(sport: sport['sport'], team_id: team['slug'])
            send_message client, data, ":face_with_head_bandage: #{team['emoji']['slack']} #{sport['emoji']} #{msg}"
          end
        end
      end

      def self.fetch_injury(sport: 'basketball', team_id: nil)
        msg = 'No recent injuries to report'

        query_params = const_get("Stattleship::Params::#{sport.capitalize}InjuriesParams").new

        if team_id
          query_params.team_id = team_id
        end

        injuries = const_get("Stattleship::#{sport.capitalize}Injuries").fetch(params: query_params)

        if injuries && injuries.count > 0

          recent_injuries = injuries.select { |injury| injury.status_updated_at > Date.today - 2 }

          if recent_injuries && recent_injuries.count > 0
            injury = recent_injuries.sample
            msg = "#{injury.note} (#{injury.status_updated_at.to_date.to_s})"
          end
        end

        msg
      end
    end
  end
end
