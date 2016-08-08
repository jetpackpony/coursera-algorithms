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
    let(:parsed_graph) { GraphSearch::Graph.new.load graph }

    it "stores outgoing connections properly" do
      expect(parsed_graph[7]).to include 1
      expect(parsed_graph[9]).to include 7
      expect(parsed_graph[9]).to include 3
      expect(parsed_graph[5]).to include 2
      expect(parsed_graph[5]).not_to include 8
    end
  end
end
