module E7SearchTest
  class Query
    attr_accessor :search_terms

    def initialize(search_terms=[], max_n)
      @search_terms = weight_search_terms(search_terms, max_n)
      @max_n = max_n
    end

    def weighting_for(term)
      @search_terms.fetch(term, 0)
    end

    private

    def weight_search_terms(terms, n)
      ranked_terms = {}
      terms.each.with_index { |k, i| ranked_terms[k.downcase] = n - i }
      ranked_terms
    end
  end
end
