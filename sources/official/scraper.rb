#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('h3').text.tidy
    end

    def position
      return raw_position unless raw_position.include? 'Prime Minister'

      raw_position.split(' and ', 2)
    end

    private

    def raw_position
      noko.css('p').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.content ul li')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
