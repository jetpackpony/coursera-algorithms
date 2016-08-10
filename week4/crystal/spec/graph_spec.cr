require "../lib/graph"
require "spec"

def graph_init
  text =
    <<-GRAPH
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
  text = text.gsub(/^\s*/, "")

  GraphSearch::Graph.new.load text
end

describe GraphSearch::Graph do

  describe "#load" do
    it "stores outgoing connections properly" do
      graph = graph_init

      graph[7].should contain 1
      graph[9].should contain 7
      graph[9].should contain 3
      graph[5].should contain 2
      graph[5].should_not contain 8
    end
  end

  describe "#[], #[]=, count" do
    it "adds the vertices correctly" do
      graph = graph_init

      graph[1] = [1,2,3]
      graph[4] = [4,5,6]
      graph[1].should eq [1,2,3]
      graph[4].should eq [4,5,6]
    end

    it "counts the vertices correctly" do
      graph = graph_init

      graph.count.should eq 9
    end
  end

  describe "#reverse" do
    it "reverses the edges correctly" do
      graph = graph_init

      graph.reverse
      graph[7].should contain 9
      graph[7].should contain 4
      graph[9].should contain 6
      graph[8].should contain 2
    end
  end
end
