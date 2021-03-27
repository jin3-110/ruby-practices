#!/usr/bin/env ruby

20.times do |count|
  count += 1
  if count % 3 == 0 && count % 5 == 0
    puts "FizzBuzz"
  elsif count % 5 == 0
    puts "Buzz"
  elsif count % 3 == 0
    puts "Fizz"
  else
    puts count
  end
end
