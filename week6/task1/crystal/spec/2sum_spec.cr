require "spec"
require "../lib/2sum"

describe TwoSum do
  describe ".str_to_set" do
    string = <<-STR
        15
        4
        6
        0
        11
        -1
      STR
      .gsub(/^\s*/, "")
    set = TwoSum.str_to_set string

    it "converts the string of integers into a set" do
      set.class.should eq Set(Int64)
    end

    it "includes the integers listed in the string" do
      set.should contain 15
      set.should contain 0
      set.should contain -1
    end

    it "does not include the integers not listed in the string" do
      set.should_not contain 44
    end
  end

  describe ".has_sum?" do
    numbers = TwoSum.str_to_set File.read "./spec/test_data/data1.txt"

    it "returns true if the 2-sum exists in the numbers list" do
      TwoSum.has_sum?(numbers, 0).should eq true
    end

    it "returns false if the 2-sum does not exist in the numbers list" do
      TwoSum.has_sum?(numbers, 3).should eq false
    end

    it "returns false if the 2-sum is a sum of same elements" do
      TwoSum.has_sum?(numbers, 4).should eq false
    end
  end

  describe ".has_range_of_sums?" do
    numbers = TwoSum.str_to_set File.read "./spec/test_data/data1.txt"

    it "returns the number of sums from the range that exist in the list" do
      TwoSum.has_range_of_sums?(numbers, (-10000..10000)).should eq 3
    end
  end
end
