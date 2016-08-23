require 'byebug'
require 'heap_general'

module Heap
  class MinHeap
    include GeneralHeap

    def get_min
      get
    end

    def extract_min
      extract
    end

    private
    def in_wrong_order?(x, y)
      @els[x] < @els[y]
    end
  end

  class MaxHeap
    include GeneralHeap

    def get_max
      get
    end

    def extract_max
      extract
    end

    private
    def in_wrong_order?(x, y)
      @els[x] > @els[y]
    end
  end
end
