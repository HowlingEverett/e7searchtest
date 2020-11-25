RSpec.describe E7SearchTest, "#rank" do
  it "outputs queries with page results ranked" do
    input_string = %{
      P Ford Car Review P Review Car
      P Review Ford P Toyota Car P Honda Car
      P Car Q Ford Q Car
      Q Review
      Q Ford Review Q Ford Car
      Q cooking French
    }

    expected_output = compact_output %{
      Q1: P1 P3
      Q2: P6 P1 P2 P4 P5
      Q3: P2 P3 P1
      Q4: P3 P1 P2
      Q5: P1 P3 P6 P2 P4
      Q6:
    }

    expect(E7SearchTest.rank(input_string, 8)).to eq expected_output
  end

  it "ranks a maximum of 5 pages per query" do
    input_string = %{
      P Ford Car P Review Car
      P Review Ford Car P Mercedes Car
      P Car P Car Ford Review
      Q Car
    }

    expected_output = compact_output %{
      Q1: P5 P6 P1 P2 P4
    }

    expect(E7SearchTest.rank(input_string, 8)).to eq expected_output
  end

  it "does not process malformed input" do
    input_string = %{Just some random text}

    expected_output = compact_output %{}

    expect(E7SearchTest.rank(input_string, 8)).to eq expected_output
  end

  private

  def compact_output(output)
    output.split("\n").map(&:strip).reject { |line| line.empty? }.join("\n")
  end
end
