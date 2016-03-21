module SlackGlickman
  module Commands
    class Feats < SlackGlickman::Commands::BaseCommand
      command ":tophat:" do |client, data, _match|
        query_params = Stattleship::Params::HockeyFeatsParams.new
        query_params.feat = 'hat_trick_goals'

        feats = Stattleship::HockeyFeats.fetch(params: query_params).
                  sample(5).
                  map(&:to_sentence).
                  join("\n")

        send_message client, data, ":tophat: Hat Tricks! \n#{feats}"
      end

      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command ":fire: :#{statmoji}:" do |client, data, _match|
          query_params = const_get("Stattleship::Params::#{sport.capitalize}FeatsParams").new
          query_params.level_up = 3
          query_params.since = 'yesterday'

          feats = const_get("Stattleship::#{sport.capitalize}Feats").
                    fetch(params: query_params).
                    sample(5).
                    map(&:to_sentence).
                    join("\n")

          send_message client, data, ":fire: Some hotness in :#{statmoji}: since #{query_params.since }! \n#{feats}"
        end
      end

      command ":rotating_light:" do |client, data, _match|
        query_params = Stattleship::Params::HockeyFeatsParams.new
        query_params.feat = 'goals'
        query_params.level_up = 0
        query_params.since = 'yesterday'

        feats = Stattleship::HockeyFeats.fetch(params: query_params).
                  sample(5).
                  map(&:to_sentence).
                  join("\n")

        send_message client, data, ":rotating_light: Light the lamp!\n#{feats}"
      end
    end
  end
end
