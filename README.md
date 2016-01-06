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

## Player Game Log

Random player game log per sport

:basketball: first_name last_name

:football: first_name last_name

:ice_hockey_stick_and_puck: first_name last_name

For example:

:basketball: Lebron James

:football: tom brady

:ice_hockey_stick_and_puck: tyler seguin

## Feats

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

:face_with_head_bandage: :basketball:

:face_with_head_bandage: :football:

:face_with_head_bandage: :ice_hockey_stick_and_puck:
