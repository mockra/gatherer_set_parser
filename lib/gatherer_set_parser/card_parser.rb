module GathererSetParser
  class CardParser

    attr_accessor :body

    def initialize card
      @body = card
    end

    def attributes
      { title: title,
        card_type: type,
        sub_type: sub_type,
        power: power,
        toughness: toughness,
        cmc: cmc,
        mana_cost: mana_cost,
        loyalty: loyalty,
        image_url: image_url,
        text: text,
        gatherer_url: gatherer_url,
        rarity: rarity }
    end

    def title
      body.css('.cardTitle > a').text
    end

    def type_box
      body.css('span.typeLine').text.
        gsub(/\n/, '').gsub(/[ ]{2,}/, ' ').strip.lstrip
    end

    def type
      type_box.match(/[a-z0-9 ]*/i).to_s.strip
    end

    def sub_type
      type_box.gsub(/\(.*\)/, '').
        match(/ ([a-z0-9 ]*)\z/i)[1].to_s.lstrip.strip
    rescue
      nil
    end

    def power
      type_box.match(/\(([0-9]*)\//)[1].to_i rescue nil
    end

    def toughness
      type_box.match(/\/([0-9]*)\)/)[1].to_i rescue nil
    end

    def cmc
      body.css('.convertedManaCost').text.to_i
    end

    def loyalty
      type_box.match(/\(([0-9]*)\)/)[1].to_i rescue nil
    end

    def rarity
      body.css('.rightCol > a').first.children.attribute('alt').text.
        match(/\((.*)\)/)[1].to_s
    end

    def text
      body.xpath('//div[@class="rulesText"]//img[@alt]').each{ |i| i.swap( i['alt'].parse_mana_cost ) }
      body.css('.rulesText').text.gsub(/[ ]{2,}/, ' ')
    end

    def mana_cost
      array = []
      body.css('.manaCost >img').each do |img|
        array << img.attribute('alt').text.parse_mana_cost
      end
      array
    end

    def image_url
      'http://gatherer.wizards.com/' +
      body.css('.leftCol > a > img').attribute('src').
        text.gsub(/\.\.\//, '')
    end

    def gatherer_url
      'http://gatherer.wizards.com/Pages/' +
      body.css('.cardTitle > a').attribute('href').
        text.gsub(/\.\.\//, '')
    end

  end
end

class String
  def parse_mana_cost
    extract_phyrexia.extract_colors.extract_unique_costs
  end

  def extract_phyrexia
    gsub(/Phyrexian Blue/, 'U/P').gsub(/Phyrexian Black/, 'B/P').
    gsub(/Phyrexian White/, 'W/P').gsub(/Phyrexian Red/, 'R/P').
    gsub(/Phyrexian Green/, 'G/P')
  end

  def extract_colors
    gsub(/Blue/, 'U').gsub(/Black/, 'B').gsub(/Red/, 'R').gsub(/Green/, 'G').
    gsub(/White/, 'W')
  end

  def extract_unique_costs
    gsub(/Variable Colorless/, 'X').gsub(/Two/, '2').gsub(/or/, '/').
    gsub(/Snow/, 'S').gsub(/Tap/, 'T').gsub(/Untap/, 'Q')
  end
end
