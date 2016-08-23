module Heap
  module GeneralHeap

    def initialize(values = [])
      @els = []
      values = [values] if !(values.is_a? Array)
      values.each { |x| insert x }
    end

    def count
      @els.count
    end

    def insert(x)
      @els.push x
      rebalance_tree
    end

    private

    def rebalance_tree
      bubble_up @els.count - 1
      bubble_down
    end

    def bubble_up(x)
      while x > 0 do
        if in_wrong_order? x, parent_for(x)
          swap x, parent_for(x)
          x = parent_for(x)
        else
          break
        end
      end
    end

    def bubble_down
      x = 0
      while x < @els.count do
        foc = first_order_child_for(x)
        break if foc.nil?
        if in_wrong_order? foc, x
          swap x, foc
          x = foc
        else
          break
        end
      end
    end

    def first_order_child_for(x)
      ch1 = x * 2
      ch2 = ch1 + 1
      return nil if ch1 > @els.count - 1
      return ch1 if ch2 > @els.count - 1
      return in_wrong_order?(ch1, ch2) ? ch1 : ch2
    end

    def parent_for(x)
      (x / 2.0).floor
    end

    def swap(x, y)
      tmp = @els[x]
      @els[x] = @els[y]
      @els[y] = tmp
    end

    def get
      @els[0]
    end

    def extract
      el = @els[0]
      @els[0] = @els.pop
      rebalance_tree
      el
    end
  end
end
