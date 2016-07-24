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
    return if r - l <= 1

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

    quick_sort(l, i - 1)
    quick_sort(i, r)
  end

  def swap i, j
    return if i == j
    tmp = @arr[i]
    @arr[i] = @arr[j]
    @arr[j] = tmp
  end

  def pivot_id l, r
    return l
  end
end

integers = []
f = File.open "IntegersQuickSort.txt"
f.each_line {|line| integers.push line.to_i}

comps = Comparisons.new(integers)

puts comps.count
puts comps.arr == comps.arr.sort

