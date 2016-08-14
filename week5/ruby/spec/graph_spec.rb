require_relative "../lib/graph"

describe Graph::Graph do
  describe "#dijkstra_shortest_paths" do
    let(:graph) { Graph::Graph.new.load IO.read "spec/test_data/graph_0.txt" }
    let(:graph1) { Graph::Graph.new.load IO.read "spec/test_data/graph_1.txt" }
    let(:graph2) { Graph::Graph.new.load IO.read "spec/test_data/graph_2.txt" }

    it "creates the graph object from the text data" do
      expect(graph.count).to eq 8
      expect(graph1.count).to eq 5
      expect(graph2.count).to eq 6
    end

    it "returns the correct edge length for given vertices" do
      expect(graph.get_vertex(1).count).to eq 2
      expect(graph1.get_vertex(4).count).to eq 3
      expect(graph2.get_vertex(2).count).to eq 3
    end

    it "calculates correct shortests paths from the given vertex" do
      paths = graph.dijkstra_shortest_paths 1
      expect(paths[5]).to eq 4
      expect(paths[6]).to eq 4

      paths = graph1.dijkstra_shortest_paths 1
      expect(paths[5]).to eq 5
      expect(paths[3]).to eq 3

      paths = graph2.dijkstra_shortest_paths 1
      expect(paths[4]).to eq 4
      paths = graph2.dijkstra_shortest_paths 2
      expect(paths[4]).to eq 3
    end
  end
end
