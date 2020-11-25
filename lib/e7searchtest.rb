require "e7searchtest/version"
require "e7searchtest/parser"
require "e7searchtest/formatter"

module E7SearchTest
  class Error < StandardError; end

  def self.rank(input, max_n = 8)
    E7PageRanker.new(input, max_n).to_s
  end

  class E7PageRanker
    def initialize(input = "", max_n = 8)
      @max_n = max_n
      @pages, @queries = parse(input)
    end

    def to_s
      Formatter.format(ranked)
    end

    private

    def parse(input)
      Parser.new(input, @max_n).parse
    end

    def ranked
      @ranked ||= @queries.map do |query|
        pages = @pages
          .reject { |page| page.weighting_for(query) == 0 }
          .sort do |a, b|
            order = b.weighting_for(query) <=> a.weighting_for(query)
            order == 0 ? a.page_number <=> b.page_number : order
          end
          .take(5) # Only include maximum five pages in the results
        RankedQuery.new(query, pages)
      end
      @ranked
    end
  end

  RankedQuery = Struct.new(:query, :pages)
end
