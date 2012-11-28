require 'open-uri'
require 'nokogiri'

module GathererSetParser
  class Fetch

    include GathererSetParser::QueryString

    attr_reader :set_name

    def response_page page
      Nokogiri::HTML open(gatherer_url page), nil, 'UTF-8'
    end

    def complete_set
      @complete_set ||= gather_set
    end

    def gather_set
      set, page = [], 0
      current_page = response_page page
      total_pages = current_page.css('.paging > a').count
      begin
        set << current_page
        page += 1
        current_page = response_page page
      end while page < total_pages - 1
      set
    end

    def cards
      @cards ||= collect_cards
    end

    def collect_cards
      collection = []
      complete_set.each do |page|
        page.css('.cardItemTable > tr > td > table').each do |card|
          collection << CardParser.new(card).attributes
        end
      end
      collection
    end

  end
end
