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
      text_data.split("\n").each do |line|
        load_line line.split(/\s+/).map(&:to_i)
      end
      self
    end

    def reverse
      new_vert = []
      self.each_with_index do |edges, vert|
        raise "the edges for #{vert} are nil for some reason" if edges.nil?
        new_vert[vert - 1] = [] if !new_vert[vert - 1]
        edges.each do |edge|
          edge -= 1
          new_vert[edge] = [] if !new_vert[edge]
          new_vert[edge].push vert
        end
      end
      @vertices = new_vert
    end

    private

    def load_line(vertex)
      self[vertex[0]] = [] if !self[vertex[0]]
      self[vertex[1]] = [] if !self[vertex[1]]
      self[vertex[0]].push vertex[1]
    end
  end
end
