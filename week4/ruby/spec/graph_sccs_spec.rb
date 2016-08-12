require_relative "../lib/graph"

describe GraphSearch::SCCs do
  let(:graph) { GraphSearch::Graph.new.load IO.read("spec/graph_0.txt") }
  let(:graph_1) { GraphSearch::Graph.new.load IO.read("spec/graph_1.txt") }

  describe "#compute_sccs" do
    it "computes strongly connected components correctly" do
      graph.compute_sccs
      graph.get_sccs.each(&:sort!)
      expect(graph.get_sccs).to include [1,4,7]
      expect(graph.get_sccs).to include [3,6,9]
      expect(graph.get_sccs).to include [2,5,8]
    end

    it "computes strongly connected components correctly" do
      graph_1.compute_sccs
      graph_1.get_sccs.each(&:sort!)
      expect(graph_1.get_sccs).to include [1,2,3]
      expect(graph_1.get_sccs).to include [9,10,11,12]
      expect(graph_1.get_sccs).to include [6,7,8]
      expect(graph_1.get_sccs).to include [5]
      expect(graph_1.get_sccs).to include [13]
      expect(graph_1.get_sccs).to include [14]
    end
  end
end
