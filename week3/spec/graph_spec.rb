require_relative '../lib/graph'
require 'byebug'

describe Graphs::Graph do
  context "simple graph parsing", focus: true do
    let(:simple_graph) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5
      2 1 3 4
      3 2 4
      4 1 2 3 5
      5 1 4

      GRAPH
    end
    let(:parsed_graph) { Graphs::Graph.new.load simple_graph}

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

    it "returns the number of vertices" do
      expect(parsed_graph.count).to eq 5
    end

    it "creates an independent copy" do
      new_graph = parsed_graph.copy
      expect(new_graph[1]).to eq parsed_graph[1]
      expect(new_graph[1]).not_to eql parsed_graph[1]
    end
  end

  context "graph with parallel edges" do
    let(:graph_with_parallels) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5 2
      2 1 3 4 1
      3 2 4 5 5
      4 1 2 3 5
      5 1 4 3 3
      GRAPH
    end
    let(:parsed_graph) { Graphs::Graph.new.load graph_with_parallels}
    
    it "returns the zero number of edges" do
      expect(parsed_graph[1].count_edges_with parsed_graph[3]).to eq 0
    end

    it "returns correct number of the parallel edges" do
      expect(parsed_graph[1].count_edges_with parsed_graph[2]).to eq 2
      expect(parsed_graph[2].count_edges_with parsed_graph[1]).to eq 2
      expect(parsed_graph[3].count_edges_with parsed_graph[5]).to eq 2
      expect(parsed_graph[5].count_edges_with parsed_graph[3]).to eq 2
      expect(parsed_graph[1].count_edges_with parsed_graph[5]).to eq 1
      expect(parsed_graph[4].count_edges_with parsed_graph[5]).to eq 1
    end

    it "replaces edges correctly" do
      parsed_graph[2].replace_edges 1, 5
      parsed_graph[3].replace_edges 4, 1
      expect(parsed_graph[2].count_edges_with parsed_graph[5]).to eq 2
      expect(parsed_graph[3].count_edges_with parsed_graph[1]).to eq 1
    end
  end

  context "contracting graphs" do
    let(:graph_text) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5
      2 1 3 4
      3 2 4
      4 1 2 3 5
      5 1 4
      GRAPH
    end
    let(:graph) { Graphs::Graph.new.load graph_text }

    let(:contracted_graph_text) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 4
      2 1 3 4
      3 2 4
      4 1 2 3 1
      GRAPH
    end
    let(:contracted_graph) { Graphs::Graph.new.load contracted_graph_text }

    it "correctly contracts graph" do
      graph.contract(1, 5)
      expect(graph).to eq contracted_graph
    end

    it "returns self if the contraction points are the same" do
      expect(graph.contract(1, 1)).to eq graph
    end

    it "correctly contracts graph when indexes are not in order" do
      skip
      expect(graph.contract(5, 1)).to eq contracted_graph
    end
  end

  context "graph with self loops" do
    let(:graph_text) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5 1
      2 1 3 4
      3 2 4 3
      4 1 2 3 5
      5 1 4
      GRAPH
    end
    let(:graph) { Graphs::Graph.new.load graph_text }

    it "removes the self loops" do
      expect(graph[1].count_edges_with graph[1]).to eq 1
      graph[1].remove_self_loops
      expect(graph[1].count_edges_with graph[1]).to eq 0
    end
  end

  context "comparing graphs" do
    let(:graph_text_1) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5
      2 1 3 4
      3 2 4
      4 1 2 3 5
      5 1 4
      GRAPH
    end
    let(:graph_1) { Graphs::Graph.new.load graph_text_1 }
    let(:graph_text_2) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 5 2 4
      2 1 3 4
      3 4 2
      4 1 3 2 5
      5 4 1
      GRAPH
    end
    let(:graph_2) { Graphs::Graph.new.load graph_text_2 }
    let(:graph_text_3) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 3
      2 1 3 4
      3 2 4
      4 1 2 2 5
      5 1 4
      GRAPH
    end
    let(:graph_3) { Graphs::Graph.new.load graph_text_3 }

    it "should correctly compare equal graphs" do
      expect(graph_1).to eq graph_1
      expect(graph_1).to eq graph_2
    end
    it "should correctly compare not equal graphs" do
      expect(graph_1).not_to eq graph_3
    end
  end

  context "large graph parsing" do
    let(:simple_graph) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5
      2 1 3 4
      3 2 4
      4 1 2 3 5
      5 1 4
      6 1 4
      7 1 4
      8 1 4
      9 1 4
      10 1 4

      GRAPH
    end
    let(:parsed_graph) { Graphs::Graph.new.load simple_graph}

    it "create vertecies from text data" do
      expect(parsed_graph[10]).to be_a Graphs::Graph::Vertex
    end

    it "assigns proper edges to vertices" do
      expect(parsed_graph[10].has_edge_with parsed_graph[1]).to be true
      expect(parsed_graph[10].has_edge_with parsed_graph[4]).to be true
    end
  end

  context "random contraction" do
    let(:graph_text) do
      <<-GRAPH.gsub(/^\s*/, "")
      1 2 4 5 1
      2 1 3 4
      3 2 4 3
      4 1 2 3 5
      5 1 4
      GRAPH
    end
    let(:graph) { Graphs::Graph.new.load graph_text }
    let(:contracted_graph_text) do
      <<-GRAPH.gsub(/^\s*/, "")
      2 3 3 3 3 3
      3 2 2 2 2 2
      GRAPH
    end
    let(:contracted_graph) { Graphs::Graph.new.load contracted_graph_text }

    it "contracts the graph over the random points" do
      srand 1234
      expect(graph.random_contract).to eq contracted_graph
    end
  end

end
