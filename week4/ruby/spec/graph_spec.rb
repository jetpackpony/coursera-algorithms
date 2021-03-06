require_relative '../lib/graph'

describe GraphSearch do
  let(:graph) { GraphSearch::Graph.new.load IO.read("spec/graph_0.txt") }
  let(:graph_1) { GraphSearch::Graph.new.load IO.read("spec/graph_1.txt") }

  describe GraphSearch::Graph do
    describe "#load" do
      it "stores outgoing connections properly" do
        expect(graph[7]).to include 1
        expect(graph[9]).to include 7
        expect(graph[9]).to include 3
        expect(graph[5]).to include 2
        expect(graph[5]).not_to include 8

        expect(graph_1[9]).to include 11
        expect(graph_1[9]).to include 8
        expect(graph_1[9]).not_to include 7
      end
    end

    describe "#reverse" do
      it "reverses the edges correctly" do
        graph.reverse
        expect(graph[7]).to include 9
        expect(graph[7]).to include 4
        expect(graph[9]).to include 6
        expect(graph[8]).to include 2

        graph_1.reverse
        expect(graph_1[11]).to include 9
        expect(graph_1[8]).to include 9
        expect(graph_1[7]).not_to include 9
      end
    end
  end
end
