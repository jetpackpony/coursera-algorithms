require_relative "../lib/graph_vertex"

describe Graph::Vertex do
  let(:vertex) { Graph::Vertex.new }

  describe "#has_edge_with" do
    it "returns nil false when there is no edge" do
      expect(vertex.has_edge_with 1).to be false
    end
    it "returns true if the edge exists" do
      vertex.add_edge 1, 1
      expect(vertex.has_edge_with 1).to be true
    end
  end

  describe "#add_edge" do
    it "adds an edge if the one didn't exist" do
      expect(vertex.has_edge_with 1).to be false
      vertex.add_edge 1, 1
      expect(vertex.has_edge_with 1).to be true
    end
    it "overrides the old edge if the one did exist" do
      vertex.add_edge 1, 1
      vertex.add_edge 1, 2
      expect(vertex.get_length_to 1).to eq 2
    end
  end

  describe "#edges" do
    it "returns an empty hash if the vertex doesn't have edges" do
      expect(vertex.edges.count).to eq 0
    end
    it "returns all the edges of the vertex" do
      vertex.add_edge 1, 1
      vertex.add_edge 2, 2
      expect(vertex.edges).to eq({ 1 => 1, 2 => 2 })
    end
  end
end
