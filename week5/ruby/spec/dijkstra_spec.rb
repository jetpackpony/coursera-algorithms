require_relative "../lib/graph"

describe Graph do
  let(:graph) { Graph::load IO.read "spec/test_data/graph_0.txt" }
  let(:graph1) { Graph::load IO.read "spec/test_data/graph_1.txt" }
  let(:graph2) { Graph::load IO.read "spec/test_data/graph_2.txt" }

  describe Graph do
    describe "#shortest_paths" do
      it "calculates correct shortests paths from the given vertex" do
        paths = Graph::shortest_paths graph, 1
        expect(paths[5]).to eq 4
        expect(paths[6]).to eq 4

        paths = Graph::shortest_paths graph1, 1
        expect(paths[5]).to eq 5
        expect(paths[3]).to eq 3

        paths = Graph::shortest_paths graph2, 1
        expect(paths[4]).to eq 4
        paths = Graph::shortest_paths graph2, 2
        expect(paths[4]).to eq 3
      end
    end
  end

end
