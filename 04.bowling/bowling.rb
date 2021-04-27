#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
frames = shots.each_slice(2).to_a

point = 0
frames.each_with_index do |f, frame_number|
  # 9フレームまで
  point += if frame_number < 9
             # 2連続ストライクの場合
             if f[0] == 10 && frames[frame_number + 1][0] == 10
               f[0] + frames[frame_number + 1][0] + frames[frame_number + 2][0]
             # 1回だけストライク
             elsif f[0] == 10
               f[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
             # スペア
             elsif f.sum == 10
               f.sum + frames[frame_number + 1][0]
             else
               f.sum
             end
           # 10フレーム目から
           else
             f.sum
           end
end
puts point
