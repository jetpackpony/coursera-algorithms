require 'byebug'
module GraphSearch
  class Graph
    include Enumerable

    def initialize
      @vertices = []
    end

    def load(text_data)
      text_data.split("\n").each do |line|
        load_line line.split(/\s+/).map(&:to_i)
      end
      self
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def count
      @vertices.count
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

    private

    def load_line(vertex)
      if !self[vertex[0]]
        self[vertex[0]] = []
      end
      self[vertex[0]].push vertex[1]
    end
  end
end
