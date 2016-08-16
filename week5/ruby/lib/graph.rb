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

    def get_vertex(index)
      @vert[real_index index]
    end

    def add_vertex(index, vertex)
      # Replace the vertex
      @vert[real_index index] = vertex

      # Create all the opposite edges
      get_vertex(index).edges.each do |vert_id, length|
        vert = get_vertex(vert_id) || Vertex.new
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
