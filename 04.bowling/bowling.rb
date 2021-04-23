#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
frames = []
frame = []
frame_count = 1
throw_count = 1

scores.each do |s|
  if frame_count < 10
    if s == 'X'
      frames << [10]
      frame_count += 1
    else
      frame << s.to_i
    end
    if frame.length == 2
      frames << frame
      frame = []
      frame_count += 1
    end
  else
    frame << if s == 'X'
               10
             else
               s.to_i
             end
    frames << frame if scores.length == throw_count
  end
  throw_count += 1
end

point = 0
MAX_FRAME = 9
frames.each_with_index do |f, frame_number|
  if frame_number < MAX_FRAME
    point += if f[0] == 10 && frames[frame_number + 1][0] == 10
               if frame_number == MAX_FRAME - 1
                 f[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
               else
                 f[0] + frames[frame_number + 1][0] + frames[frame_number + 2][0]
               end
             elsif f[0] == 10
               f[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
             elsif f.sum == 10
               f.sum + frames[frame_number + 1][0]
             else
               f.sum
             end
  elsif frame_number == MAX_FRAME
    point += f.sum
  end
end
puts point
