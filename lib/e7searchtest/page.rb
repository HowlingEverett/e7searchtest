module E7SearchTest
  class Page
    attr_reader :page_number

    def initialize(keywords, page_number, n)
      @keywords = weight_keywords(keywords, n)
      @page_number = page_number
    end

    def weighting_for(query)
      query.search_terms.keys.reduce(0) do |total, query_keyword|
        total + @keywords.fetch(query_keyword.downcase, 0) * query.weighting_for(query_keyword)
      end
    end

    private

    def weight_keywords(keywords, n)
      ranked_keywords = {}
      keywords.each.with_index { |k, i| ranked_keywords[k.downcase] = n - i }
      ranked_keywords
    end
  end
end
