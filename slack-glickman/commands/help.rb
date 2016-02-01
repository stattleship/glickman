module SlackGlickman
  module Commands
    class Help < SlackGlickman::Commands::BaseCommand
      command "help" do |client, data, _match|
        options = {}
        text = [SlackGlickman::App.instance.help['info'], '']
        text <<  SlackGlickman::App.instance.help['intro']
        text << ''

        SlackGlickman::App.instance.help['commands'].each do |key, values|
          text << "#{values['expression']} - #{values['description']}"
        end

        client.say(options.merge(channel: data.channel, text: text.join("\n")))
      end

      command "about" do |client, data, _match|
        options = {}
        client.say(options.merge(channel: data.channel, text: SlackGlickman::App.instance.help['info']))
      end

      command "me" do |client, data, _match|
        options = {}
        client.say(options.merge(channel: data.channel, text: "Hi <@#{data.user}>"))
      end
    end
  end
end
