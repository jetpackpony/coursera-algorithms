require 'byebug'

class Inversions
  def initialize arr
    @counter = 0
    @arr = arr
  end

  def count_inversions
    puts @arr.length
    arr = count @arr
    puts arr.length
    return @counter
  end

  private

  def count arr
    return arr if arr.length == 1
    split = arr.each_slice((arr.length / 2.0).ceil).to_a
    return merge count(split[0]), count(split[1])
  end

  def merge(arr1, arr2)
    res = []
    i = j = 0
    (arr1.length + arr2.length).times do
      if !arr1[i]
        res.push arr2[j]
        j += 1
        next
      end

      if !arr2[j]
        res.push arr1[i]
        i += 1
        next
      end

      if arr1[i] > arr2[j]
        res.push arr2[j]
        j += 1
        @counter += arr1.length - i
      else
        res.push arr1[i]
        i += 1
      end
    end
    res
  end
end

integers = []
f = File.open "integer_array.txt"
#f = File.open "short_array.txt"
f.each_line {|line| integers.push line.to_i}

inv = Inversions.new integers
puts inv.count_inversions
