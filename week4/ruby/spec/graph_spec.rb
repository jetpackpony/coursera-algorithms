require_relative '../lib/graph'

describe GraphSearch do
  let(:graph) { GraphSearch::Graph.new.load IO.read("spec/graph_0.txt") }

  describe GraphSearch::Graph do
    describe "#load" do
      it "stores outgoing connections properly" do
        expect(graph[7]).to include 1
        expect(graph[9]).to include 7
        expect(graph[9]).to include 3
        expect(graph[5]).to include 2
        expect(graph[5]).not_to include 8
      end
    end

    describe "#reverse" do
      it "reverses the edges correctly" do
        graph.reverse
        expect(graph[7]).to include 9
        expect(graph[7]).to include 4
        expect(graph[9]).to include 6
        expect(graph[8]).to include 2
      end
    end
  end
end
