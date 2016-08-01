module Graphs
  class Graph
    attr_reader :vertices
    def initialize
      @vertices = []
    end

    def load(text_data)
      text_data.split("\n").each do |edges|
        edges = edges.split(%r{\s+}).map!(&:to_i)
        vert = Vertex.new(edges.shift)
        vert.add_edges(edges)
        self.push vert
      end
      self
    end

    def [](x)
      @vertices[x - 1]
    end

    def push(vertex)
      @vertices.push vertex
    end

    def delete(x)
      @vertices[x - 1] = nil
    end

    def count
      @vertices.select{ |x| !x.nil? }.count
    end

    def contract(v1, v2)
      return self if v1 == v2
      @vertices.each do |vert|
        if vert.nil? || vert.id == v2
          next
        end

        if vert.id == v1
          vert.add_edges self[v2].edges
        end

        vert.replace_edges v2, v1
        vert.remove_self_loops
      end
      delete v2
      self
    end

    def random_contract
      while self.count > 2
        contract(random_vertex, random_vertex)
      end
      self
    end

    def random_vertex
      vertices.select{ |x| !x.nil? }.sample.id
    end

    def first
      vertices.select{ |x| !x.nil? }.first
    end

    def copy
      new_graph = Graph.new
      vertices.each { |vert| new_graph.push vert.copy }
      new_graph
    end

    def ==(other)
      left = vertices.select{ |x| !x.nil? }.sort { |x,y| x.id <=> y.id }
      right = other.vertices.select{ |x| !x.nil? }.sort { |x,y| x.id <=> y.id }
      left == right
    end

    def inspect
      vertices.map { |vert| vert.inspect + "\n" }
    end

    class Vertex
      attr_reader :id
      attr_reader :edges
      def initialize(id)
        @id = id
        @edges = []
      end

      def add_edges(vertices)
        @edges.concat vertices
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
        return false if other.nil?
        id == other.id &&
          edges.sort == other.edges.sort
      end

      def copy
        new_vert = Vertex.new id
        new_vert.add_edges @edges
        new_vert
      end
    end
  end
end
