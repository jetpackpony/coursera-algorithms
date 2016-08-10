require_relative '../lib/graph_search'

describe GraphSearch do
  let(:graph_data) {
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
  let(:graph) { GraphSearch::Graph.new.load graph_data }
  let(:graph_data_1) {
    <<-GRAPH.gsub(/^\s*/, '')
    1 2
    2 3
    3 1
    2 5
    5 6
    6 7
    7 8
    8 6
    3 9
    3 12
    12 9
    9 10
    10 11
    11 12
    9 11
    9 8
    10 7

    GRAPH
  }
  let(:graph_1) { GraphSearch::Graph.new.load graph_data_1 }

  describe GraphSearch::Graph do
    describe "#[], #[]=, count" do
      it "adds the vertices correctly" do
        graph[1] = [1,2,3]
        graph[4] = [4,5,6]
        expect(graph[1]).to eq [1,2,3]
        expect(graph[4]).to eq [4,5,6]
      end

      it "counts the vertices correctly" do
        expect(graph.count).to eq 9
      end
    end


    describe "#load" do
      it "stores outgoing connections properly" do
        expect(graph[7]).to include 1
        expect(graph[9]).to include 7
        expect(graph[9]).to include 3
        expect(graph[5]).to include 2
        expect(graph[5]).not_to include 8
      end
    end

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

    # These tests are coupled with implementation.
    # Disregard if failing after refactoring
    describe "PRIVATE" do

    end
  end
end
