module Graphs
  class Graph
    def initialize(text_data)
      @vertices = []
      text_data.split("\n").each do |edges|
        edges = edges.split(%r{\s*}).map!(&:to_i)
        vert = Vertex.new edges.shift
        edges.each do |ed|
          vert.add_edge ed
        end
        @vertices.push vert
      end
    end

    def [](x)
      @vertices[x - 1]
    end

    class Vertex
      attr_reader :id
      def initialize(id)
        @id = id
        @edges = []
      end

      def add_edge(vertex)
        @edges.push vertex
      end

      def has_edge_with(vertex)
        @edges.include? vertex.id
      end
    end
  end
end
