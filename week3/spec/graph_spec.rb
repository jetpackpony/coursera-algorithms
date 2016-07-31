require_relative '../lib/graph'
require 'byebug'

describe Graphs::Graph do
  context "simple graph parsing" do
    let(:simple_graph) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5
      2 1 3 4
      3 2 4
      4 1 2 3 5
      5 1 4
      GRAPH
    end
    let(:parsed_graph) { Graphs::Graph.new simple_graph}

    it "create vertecies from text data" do
      expect(parsed_graph[1]).to be_a Graphs::Graph::Vertex
      expect(parsed_graph[2]).to be_a Graphs::Graph::Vertex
      expect(parsed_graph[3]).to be_a Graphs::Graph::Vertex
    end

    it "assigns proper edges to vertices" do
      expect(parsed_graph[1].has_edge_with parsed_graph[2]).to be true
      expect(parsed_graph[1].has_edge_with parsed_graph[4]).to be true
      expect(parsed_graph[1].has_edge_with parsed_graph[5]).to be true
      expect(parsed_graph[4].has_edge_with parsed_graph[3]).to be true
      expect(parsed_graph[3].has_edge_with parsed_graph[4]).to be true
      expect(parsed_graph[5].has_edge_with parsed_graph[1]).to be true
      expect(parsed_graph[5].has_edge_with parsed_graph[4]).to be true
    end
  end
end
