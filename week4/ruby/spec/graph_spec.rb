require_relative '../lib/graph_search'

describe GraphSearch do
  describe GraphSearch::Graph do
    let(:graph) {
      <<-GRAPH.gsub(/^\s*/, '')
      7 1
      1 4
      4 7
      9 7
      9 3
      3 6
      6 9
      8 6
      2 8
      5 2
      8 5

      GRAPH
    }
  end
end
