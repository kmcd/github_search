require 'net/http'
require 'uri'
    
module Github
  #
  # A wrapper for the github search page http://github.com/search
  #
  # USAGE
  #
  # s = Github::Search.new :type => :user, :query => 'location:UK'
  # s.results
  # => [ <#Rubyist name=kmcd>, ... ]
  #
  class Search
    # TODO: rdoc
    def initialize(opts)
      @query, @type, @language = opts[:query], opts[:type], opts[:language]
    end
    
    # TODO: rdoc
    def results
      fetch_all_paginated_result_pages
      # build array of (Rubyist, Repo ..)
    end
    
    private
    
    def fetch_all_paginated_result_pages
      Net::HTTP.get_print URI.parse search_url
    end
    
    def search_url
      # FIXME: dont add query param unless instance_variable set
      "https://github.com/search?langOverride=#{@language}&language=&q=#{@query}&&type=#{@type}"
    end
    
    # start_value=2 for pagination
  end
end