module Graphs
  class Graph
    attr_reader :vertices
    def initialize
      @vertices = []
    end

    def load(text_data)
      text_data.split("\n").each do |edges|
        edges = edges.split(%r{\s*}).map!(&:to_i)
        vert = Vertex.new(edges.shift)
        vert.add_edges(edges)
        self.push vert
      end
      self
    end

    def [](x)
      @vertices.find { |v| v.id == x }
    end

    def push(vertex)
      @vertices.push vertex
    end

    def count
      @vertices.count
    end

    def contract(v1, v2)
      new_graph = Graph.new
      @vertices.each do |vert|
        if vert.id == v2
          next
        end
        if vert.id == v1
          vert.add_edges self[v2].edges
          vert.replace_edges v2, v1
          vert.remove_self_loops
          new_graph.push vert
        elsif vert.has_edge_with self[v2]
          vert.replace_edges v2, v1
          new_graph.push vert
        else
          new_graph.push vert
        end
      end
      new_graph
    end

    def ==(other)
      vertices.sort { |x,y| x.id <=> y.id } == other.vertices.sort { |x,y| x.id <=> y.id }
    end

    class Vertex
      attr_reader :id
      attr_reader :edges
      def initialize(id)
        @id = id
        @edges = []
      end

      def add_edge(vertex)
        @edges.push vertex
      end

      def add_edges(vertices)
        vertices.each { |vertex| add_edge vertex }
      end

      def has_edge_with(vertex)
        @edges.include? vertex.id
      end

      def count_edges_with(vertex)
        @edges.count vertex.id
      end

      def replace_edges(from, to)
        @edges.map! { |edge| edge == from ? to : edge }
      end

      def remove_self_loops
        @edges.select! { |edge| edge != id }
      end

      def ==(other)
        id == other.id &&
          edges.sort == other.edges.sort
      end
    end
  end
end
