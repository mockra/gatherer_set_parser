# GathererSetParser

This is a tool for parsing the official Magic the Gathering card database for 
a complete collection of cards belonging to a specific set. The cards of the 
given set will be returned in an array of hashes.

This gem was extracted from a personal project, and hasn't been throughly 
tested for every set in production. You'll likely want to refactor a lot of 
the code before using it on a production server.

## Installation

Add this line to your application's Gemfile:

    gem 'gatherer_set_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gatherer_set_parser

## Usage

This set requires you to pass in a case sensitive set name from the Gatherer
website. Here's an example:

```
  # Create the array of cards from the given set name
  cards = GathererSetParser::Fetch.new('Dark Ascension').cards
```

This will return an array of 171 cards. Here's an example of the output of 
cards.first:

```
  { :title=> "Afflicted Deserter",
  :card_type => "Creature",
  :sub_type => "",
  :power => 3,
  :toughness => 2,
  :cmc => 4,
  :mana_cost => ["3", "R"],
  :loyalty => nil,
  :image_url => "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=262675&type=card",
  :text => "\r\n At the beginning of each upkeep, if no spells were cast last turn, transform Afflicted Deserter.",
  :gatherer_url => "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=262675",
  :rarity => "Uncommon" }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

[david@mockra.com](mailto:david@mockra.com)

[@Mockra_](http://twitter.com/#!/mockra_)

[mockra.com](http://mockra.com)
