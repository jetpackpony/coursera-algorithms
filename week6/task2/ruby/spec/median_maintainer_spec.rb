require_relative "../lib/median_maintainer"

describe MedianMaintainer do
  context "(with simple integers)" do
    let(:mm) { MedianMaintainer.new.add [1,2,3,4,5] }

    it "accepts an array of values as a value" do
      expect(mm.count).to eq 5
    end
    it "accepts a single number as the value" do
      mm.add 3
      expect(mm.count).to eq 6
    end
    it "returns a median of the numbers recieved so far" do
      expect(mm.median).to eq 3
    end
    it "updates the median after recieving an element" do
      mm.add 2
      expect(mm.median).to eq 2
    end
  end

  context "(with complex integers)" do
    let(:mm) { MedianMaintainer.new.add [9,8,4,12,9,4,13,4,11] }

    it "returns a median of the numbers recieved so far" do
      expect(mm.median).to eq 9
    end
    it "updates the median after recieving an element" do
      mm.add [18,19,20,21,22]
      expect(mm.median).to eq 11
    end
  end
end
