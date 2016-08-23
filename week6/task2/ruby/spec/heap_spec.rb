require_relative "../lib/heap"

describe Heap do

  describe Heap::MinHeap do
    let(:heap) { Heap::MinHeap.new [9,8,4,12,9,4,13,4,11] }

    it "rebalances the tree after inserting the element" do
      heap.insert 1
      expect(heap.get_min).to eq 1
    end

    it "returns the correct count of elements" do
      expect(heap.count).to eq 9
    end
    it "returns the smallest element" do
      expect(heap.get_min).to eq 4
    end
    it "extracts the smallest element and returns it" do
      expect(heap.extract_min).to eq 4
      expect(heap.extract_min).to eq 4
      expect(heap.extract_min).to eq 4
      expect(heap.extract_min).to eq 8
      expect(heap.get_min).to eq 9
    end
  end

  describe Heap::MaxHeap do
    let(:heap) { Heap::MaxHeap.new [9,8,4,12,9,4,13,4,11] }

    it "rebalances the tree after inserting the element" do
      heap.insert 18
      expect(heap.get_max).to eq 18
    end

    it "returns the correct count of elements" do
      expect(heap.count).to eq 9
    end

    it "returns the largest element" do
      expect(heap.get_max).to eq 13
    end
    it "extracts the largest element and returns it" do
      expect(heap.extract_max).to eq 13
      expect(heap.extract_max).to eq 12
      expect(heap.get_max).to eq 11
    end
  end
end
