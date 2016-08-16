require_relative "../lib/graph"

describe Graph do
  let(:graph) { Graph::load IO.read "spec/test_data/graph_0.txt" }
  let(:graph1) { Graph::load IO.read "spec/test_data/graph_1.txt" }
  let(:graph2) { Graph::load IO.read "spec/test_data/graph_2.txt" }

  describe Graph::Graph do
    describe "#load" do
      it "creates the graph object from the text data" do
        expect(graph.count).to eq 8
        expect(graph1.count).to eq 5
        expect(graph2.count).to eq 6
      end

      it "creates vertices with the correct edges" do
        expect(graph[1].has_edge_with 2).to be true
        expect(graph[1].has_edge_with 2).to be true

        expect(graph1[1].has_edge_with 2).to be true
        expect(graph1[1].has_edge_with 4).to be true

        expect(graph2[3].has_edge_with 4).to be true
        expect(graph2[3].has_edge_with 1).to be true
      end

      it "does not create vertices with wrong edges" do
        expect(graph[1].has_edge_with 3).to be false
        expect(graph[6].has_edge_with 8).to be false

        expect(graph1[1].has_edge_with 5).to be false
        expect(graph1[4].has_edge_with 2).to be false

        expect(graph2[1].has_edge_with 4).to be false
        expect(graph2[3].has_edge_with 6).to be false
      end

      it "creates vertices with correct edge lengths" do
        expect(graph[1].edges[8]).to eq 2
        expect(graph1[1].edges[4]).to eq 2
        expect(graph2[1].edges[2]).to eq 3
      end
    end
  end
end
