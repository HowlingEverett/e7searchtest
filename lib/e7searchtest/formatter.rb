module E7SearchTest
  module Formatter
    def self.format(queries)
      queries.map.with_index do |ranked_query, index|
        pages = ranked_query.pages.map { |page| "P#{page.page_number}"}.join(" ")
        ["Q#{index + 1}:", pages].reject(&:empty?).join(" ")
      end.join("\n")
    end
  end
end
