module GathererSetParser
  module QueryString

    def initialize set
      @set_name = set
    end

    def escaped_set
      @query_string ||= URI.escape set_name
    end

    def query_string
      "output=standard&set=[%22#{escaped_set}%22]"
    end

    def url
      "http://gatherer.wizards.com/Pages/Search/Default.aspx?"
    end

    def gatherer_url page
      url + query_string + "&page=#{page}"
    end

  end
end
