#!/usr/bin/env ruby

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
    if s == 'X'
      frame << 10
    else
      frame << s.to_i
    end
    if scores.length == throw_count
      frames << frame
    end
  end
  throw_count += 1
end

point = 0
frame_number = 0
max_frame = 9
frames.each do |f|
  if frame_number < 9
    if f[0] == 10 && frames[frame_number + 1][0] == 10
      if frame_number == 8
        point += f[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
      else
      point += f[0] + frames[frame_number + 1][0] + frames[frame_number + 2][0]
      end
    elsif f[0] == 10
      point += f[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
    elsif f.sum == 10
      point += f.sum + frames[frame_number + 1][0]
    else
      point += f.sum
    end
  elsif frame_number == max_frame
    point += f.sum
  end
  frame_number += 1
end
puts point
