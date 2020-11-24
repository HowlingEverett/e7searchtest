require "e7searchtest/page"

RSpec.describe E7SearchTest::Page do
  context "#weighting_for" do
    it "weights keywords in order of definition" do
      keywords = %w(Review Ford)
      page = E7SearchTest::Page.new(keywords, 1, 8)

      expect(page.weighting_for(E7SearchTest::Query.new(%w[Review], 8))).to eq 64
      expect(page.weighting_for(E7SearchTest::Query.new(%w[Ford], 8))).to eq 56
    end

    it "combines multiple query keywords into a single weighting" do
      keywords = %w(Review Ford Car)
      page = E7SearchTest::Page.new(keywords, 1, 8)

      expected_weighting = (8 * 8) + (6 * 7)

      expect(page.weighting_for(E7SearchTest::Query.new(%w[Review Car], 8))).to eq expected_weighting
    end

    it "has no weighting for unknown terms" do
      keywords = %w(Review Ford)
      page = E7SearchTest::Page.new(keywords, 1, 8)

      expect(page.weighting_for(E7SearchTest::Query.new(%w(Cooking), 8))).to eq(0)
    end

    it "ignores case when weighting query terms" do
      keywords = %w(Review Ford)
      page = E7SearchTest::Page.new(keywords, 1, 8)

      expect(page.weighting_for(E7SearchTest::Query.new(%w(review), 8))).to eq 64
    end
  end
end
