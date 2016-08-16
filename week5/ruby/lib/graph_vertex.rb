module Graph
  class Vertex
    attr_reader :edges

    def initialize
      @edges = {}
    end

    def has_edge_with(other_id)
      !@edges[other_id].nil?
    end

    def add_edge(other_id, length)
      @edges[other_id] = length
    end

    def get_length_to(other_id)
      @edges[other_id]
    end
  end
end
