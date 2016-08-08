require "./vertex"

module Graphs
  class Graph
    getter :vertices

    def initialize
      @vertices = [] of Vertex
    end

    def load(text_data)
      text_data.strip.split("\n").each do |edges|
        edges = edges.strip.split(%r{\s+}).map { |x| x.to_i }
        vert = Graphs::Vertex.new(edges.shift)
        vert.add_edges(edges)
        self.push vert
      end
      self
    end

    def [](x)
      @vertices.find {|v| v.id == x } || raise "Vertex with the id #{x} not found"
    end

    def push(vertex)
      @vertices.push vertex
    end

    def delete(x)
      @vertices.delete self[x]
    end

    def size
      @vertices.select{ |x| !x.nil? }.size
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

    def contract(v1, v2)
      return self if v1 == v2
      vert1 = self[v1]
      vert2 = self[v2]
      return self if !vert1.has_edge_with(vert2)
      @vertices.each do |vert|
        if vert.nil? || vert == vert2
          next
        end

        if vert == vert1
          vert.add_edges vert2.edges
        end

        vert.replace_edges vert2.id, vert1.id
        vert.remove_self_loops
      end
      delete vert2.id
      self
    end

    def random_contract
      while self.size > 2
        contract(random_vertex, random_vertex)
      end
      self
    end

    def random_vertex
      vertices.select{ |x| !x.nil? }.sample.id
    end
  end
end
