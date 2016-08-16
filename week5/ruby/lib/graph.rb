require 'byebug'
require_relative './graph_dijkstra'
require_relative './graph_loader'
require_relative './graph_vertex'

module Graph
  class Graph
    def initialize
      @vert = []
    end

    def count
      @vert.count
    end

    def [](index)
      @vert[real_index index]
    end

    def []=(index, vertex)
      # Replace the vertex
      @vert[real_index index] = vertex

      # Create all the opposite edges
      self[index].edges.each do |vert_id, length|
        vert = self[vert_id] || Vertex.new
        vert.add_edge index, length
        @vert[real_index vert_id] = vert
      end
    end

    private

    def real_index(index)
      index - 1
    end
  end

end
