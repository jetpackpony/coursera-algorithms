module Graph
  module Enum
    include Enumerable

    def initialize
      @vertices = []
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(vertex, edges)
      edges = [edges] if !(edges.is_a? Array)
      edges.each do |edge|
        add_edge vertex, edge
        add_edge edge, vertex
      end
    end

    def add_edge(from, to)
      from -= 1
      @vertices[from] = [] if @vertices[from].nil?
      @vertices[from].push to if !@vertices[from].include? to
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
