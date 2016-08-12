module GraphSearch
  module Enum
    include Enumerable

    def initialize
      @vertices = []
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def push(el)
      @vertices.push el
    end

    def count
      @vertices.select { |x| !x.nil? }.count
    end

    def each(&block)
      @vertices.each do |vert|
        next if vert.nil?
        block.call(vert)
      end
    end

    def each_with_index(&block)
      @vertices.each_with_index do |vert, index|
        next if vert.nil?
        block.call(vert, index + 1)
      end
    end

    def each_index(&block)
      @vertices.each_with_index do |vert, index|
        next if vert.nil?
        block.call(index + 1)
      end
    end

  end
end
