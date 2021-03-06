module Graphs
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
