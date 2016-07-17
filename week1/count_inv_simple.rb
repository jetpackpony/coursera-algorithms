require 'byebug'

integers = []
f = File.open "integer_array.txt"
f.each_line {|line| integers.push line.to_i}

count = 0

for i in 0..(integers.length - 1) do
  for j in (i + 1)..(integers.length - 1) do
    if integers[i] > integers[j]
      count += 1
    end
  end
end

puts count
