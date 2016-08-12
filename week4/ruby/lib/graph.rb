require 'byebug'
require_relative './log'
require_relative './graph_enum'
require_relative './graph_sccs'

module GraphSearch
  class Graph
    include GraphSearch::Enum
    include GraphSearch::SCCs

    def initialize(log = Log.new('none'))
      super()
      @log = log
    end

    def log(text)
      @log.log text
    end

    def prev_time
      @log.prev_time
    end

    def load(text_data)
      text_data
        .split(/\s+/)
        .map(&:to_i)
        .each_slice(2) do |els|
          load_edge els[0], els[1]
        end
      self
    end

    def reverse
      new_vert = []
      self.each_with_index do |edges, vert|
        new_vert[vert - 1] || new_vert[vert - 1] = []
        edges.each do |edge|
          edge -= 1
          new_vert[edge] = [] if !new_vert[edge]
          new_vert[edge].push vert
        end
      end
      @vertices = new_vert
    end

    private

    def load_edge(v1, v2)
      self[v1] || self[v1] = []
      self[v2] || self[v2] = []
      self[v1].push v2
    end
  end
end
