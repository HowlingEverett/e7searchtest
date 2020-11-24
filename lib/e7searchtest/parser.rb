require "strscan"
require "e7searchtest/page"
require "e7searchtest/query"

module E7SearchTest
  class Parser
    def initialize(input = "", max_n = 8)
      @buffer = StringScanner.new(input)
      @pages = []
      @queries = []
      @max_n = max_n
    end

    def parse
      until @buffer.eos?
        code_letter = @buffer.scan_until(/\b?(P|Q)\b/)
        break unless code_letter

        if code_letter.strip.downcase[-1] == "p"
          @pages << Page.new(find_terms, @pages.count + 1, @max_n)
        elsif code_letter.strip.downcase[-1] == "q"
          @queries << Query.new(find_terms, @max_n)
        end
      end

      [@pages, @queries]
    end

    private

    def find_terms
      tags = @buffer.scan_until(/\b?(P|Q)\b/)
      if tags
        # Walk back to before the next matched code letter
        @buffer.pos = @buffer.pos - 1
        tags = tags.chop
      else
        tags = @buffer.rest() || ""
        @buffer.terminate()
      end
      tags.strip.split(/\s/).map(&:strip)
    end
  end
end
