require 'byebug'

class Comparisons
  attr_reader :arr
  attr_reader :count

  def initialize arr
    @arr = arr
    @count = 0

    quick_sort 0, @arr.length - 1
  end

  private

  def quick_sort l, r
    return if (r - l + 1) <= 1

    @count += (r - l)

    i = l + 1
    swap(pivot_id(l, r), l)

    i.upto(r) do |j|
      if @arr[j] < @arr[l]
        swap(i, j)
        i += 1
      end
    end
    
    swap(i - 1, l)

    quick_sort(l, i - 2)
    quick_sort(i, r)
  end

  def swap i, j
    return if i == j
    tmp = @arr[i]
    @arr[i] = @arr[j]
    @arr[j] = tmp
  end

  def pivot_id l, r
    # Task 1
    #return l

    # Task 2
    #return r

    # Task 3
    return get_median l, r
  end

  def get_median l, r
    middle = ((r - l) / 2.0).floor + l

    median = ([@arr[l], @arr[middle], @arr[r]].sort)[1]

    return l if median == @arr[l]
    return middle if median == @arr[middle]
    return r if median == @arr[r]
  end
end

integers = []
f = File.open "IntegersQuickSort.txt"
f.each_line {|line| integers.push line.to_i}

#integers = [8,2,6,5,1,4,3,9,0,7]


comps = Comparisons.new(integers)

puts comps.count
puts comps.arr == comps.arr.sort

