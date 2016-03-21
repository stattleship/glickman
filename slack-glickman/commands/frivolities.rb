module SlackGlickman
  module Commands
    class Frivolities < SlackGlickman::Commands::BaseCommand
      command ":batpig:" do |client, data, _match|
        send_gif(client, data.channel, 'french bulldog')
      end

      command ":eggplant:" do |client, data, _match|
        send_gif(client, data.channel, 'brett favre')
      end

      command ":eyeglasses:" do |client, data, _match|
        # send_gif(client, data, 'major league wild thing')
        send_message_with_gif(client, data.channel, 'Just a bit outside ...', 'major league wild thing')
      end

      command ":unicorn_face:" do |client, data, _match|
        send_message client, data, ":rainbow: :rainbow: :rainbow: :rainbow: :rainbow:"
      end

      command ":pizza:" do |client, data, _match|
        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-peyton-manning'
        query_params.season_id = 'nfl-2015-2016'
        query_params.interval_type = 'superbowl'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        msg = game_logs.sample.to_sentence rescue 'Guys, if you want to play sports, go ahead, but it’s your decision.'

        send_message client, data, ":pizza: #{msg}"
      end

      command ":table_tennis_paddle_and_ball:" do |client, data, _match|
        send_gif(client, data.channel, 'pong')
      end
    end
  end
end
