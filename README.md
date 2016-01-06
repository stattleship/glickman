# glickman

Glickman is your statmoji(tm) sports slackbot powered by the Stattleship API. [https://www.stattleship.com](https://www.stattleship.com).

Its namesake is [Marty Glickman](https://en.wikipedia.org/wiki/Marty_Glickman), a pioneering American radio announcer and sportscaster.

This bot is make possible by [Slack-Ruby-Bot](https://github.com/dblock/slack-ruby-bot), a generic Slack bot framework written in Ruby on top of [slack-ruby-client](https://github.com/dblock/slack-ruby-client).

It also relies on the [stattleship-ruby](https://github.com/stattleship/stattleship-ruby) gem to fetch sports stats and info.

# Installation

See: https://github.com/dblock/slack-ruby-bot/blob/master/TUTORIAL.md

After bundling and setting up your `.env` file the the API keys, you should be able to run `foreman start` to get the bot up and running.

Note: current uses a pre-release version the the [stattleship-ruby](https://github.com/stattleship/stattleship-ruby) gem.

## Stattleship API Key

You'll need a `.env` with API keys

```
SLACK_API_TOKEN=
STATTLESHIP_ACCESS_TOKEN=
```

You can get a Stattleship API key at [http://www.stattleship.com](http://www.stattleship.com).

# Commands

Glickman knows a good deal about sports.

![What's hot in basketball](/screenshots/fire_basketball.gif?raw=true "What's hot in basketball")


## Player Game Log

Random player game log per sport

![Basketball Game Log](/screenshots/basketball_player_game_log.gif?raw=true "Basketball Game Log")

:basketball: first_name last_name

:football: first_name last_name


![Hockey Game Log](/screenshots/hockey_player_game_log.gif?raw=true "Hockey Game Log")


:ice_hockey_stick_and_puck: first_name last_name

For example:

:basketball: Lebron James

:football: tom brady

:ice_hockey_stick_and_puck: tyler seguin

## Feats

![Feats in action](/screenshots/feats.gif?raw=true "Feats in action")

:tophat: Hat tricks in hockey

:fire: :basketball:

:fire: :football:

:fire: :ice_hockey_stick_and_puck:

## Stat Leaders

Goalie shutout leaders

:doughnut:

Rusing yard leaders

:runner:

## Top Stats

Top field goals made basketball performances

:rain_cloud:

Top three pointers basketball performances

:thunder_cloud_and_rain:

## Games/Scores

In-progress game scores per sport

:mega: :basketball:

:mega: :football:

:mega: :ice_hockey_stick_and_puck:

## Injuries

Random injury report per sport

![Injury report](/screenshots/injuries.gif?raw=true "Injury report")

:face_with_head_bandage: :basketball:

:face_with_head_bandage: :football:

:face_with_head_bandage: :ice_hockey_stick_and_puck:

## Players

Use teamoji(tm) to get a list of player deets.

![Players](/screenshots/players.gif?raw=true "Players")

Celtics

:four_leaf_clover: :basketball:

76ers

:statue_of_liberty: :basketball:

All bears!

![Bears](/screenshots/players_bears.gif?raw=true "Bears")

Chicago Bears

:bear: :football:

Memphis Grizzlies

:bear: :basketball:

Boston Bruins

:bear: :ice_hockey_stick_and_puck:

More teams coming soon.
