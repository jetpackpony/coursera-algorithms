require_relative "../lib/2sum"

describe TwoSum do
  describe ".str_to_set" do
    let(:string) do
      <<-STR.gsub(/^\s*/, "")
        15
        4
        6
        0
        11
        -1
      STR
    end
    let(:set) { TwoSum.str_to_set string }

    it "converts the string of integers into a set" do
      expect(set).to be_a Set
    end

    it "includes the integers listed in the string" do
      expect(set).to include 15
      expect(set).to include 0
      expect(set).to include -1
    end
    it "does not include the integers not listed in the string" do
      expect(set).not_to include 44
    end
  end

  describe ".has_sum?" do
    let(:string_data) { IO.read "spec/test_data/data1.txt" }
    let(:numbers) { TwoSum.str_to_set string_data }

    it "returns true if the 2-sum exists in the numbers list" do
      expect(TwoSum.has_sum? numbers, 0).to be true
    end

    it "returns false if the 2-sum does not exist in the numbers list" do
      expect(TwoSum.has_sum? numbers, 3).to be false
    end

    it "returns false if the 2-sum is a sum of same elements" do
      expect(TwoSum.has_sum? numbers, 4).to be false
    end
  end

  describe ".has_range_of_sums?" do
    let(:string_data) { IO.read "spec/test_data/data1.txt" }
    let(:numbers) { TwoSum.str_to_set string_data }

    it "returns the number of sums from the range that exist in the list" do
      expect(TwoSum.has_range_of_sums? numbers, (-10000..10000)).to eq 3
    end
  end
end
