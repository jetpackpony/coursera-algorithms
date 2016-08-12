require_relative '../lib/graph_enum'

describe GraphSearch::Enum do
  let(:graph) { Class.new{ include GraphSearch::Enum}.new }

  describe "#[], #[]=" do
    it "adds and retrieves the vertices correctly" do
      graph[1] = [1,2,3]
      graph[4] = [4,5,6]
      expect(graph[1]).to eq [1,2,3]
      expect(graph[4]).to eq [4,5,6]
    end
  end
  describe "count" do
    it "counts the vertices correctly" do
      graph[1] = [1,2,3]
      graph[2] = [1,2,3]
      graph[3] = [1,2,3]
      expect(graph.count).to eq 3
    end

    it "doesn't count the vertices that are nil" do
      graph[3] = [1,2,3]
      expect(graph.count).to eq 1
    end
  end
end
