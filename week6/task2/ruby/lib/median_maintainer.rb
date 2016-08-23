require 'heap'
require 'byebug'

class MedianMaintainer
  include Heap

  def initialize
    @left = MaxHeap.new
    @right = MinHeap.new
  end

  def add(value)
    value = [value] if !(value.is_a? Array)
    value.each do |x|
      insert x
    end
    self
  end

  def count
    @left.count + @right.count
  end

  def median
    return 0 if self.count == 0
    return @left.get_max if self.count.even?
    return @right.get_min if self.count.odd?
  end

  private

  def insert(x)
    @left.insert x if x <= median
    @right.insert x if x > median
    rebalance_heaps
  end

  def rebalance_heaps
    while @right.count > @left.count + 1
      @left.insert @right.extract_min
    end
    while @left.count > @right.count
      @right.insert @left.extract_max
    end
  end
end
