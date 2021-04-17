#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
frames = []
frame = []
throw_count = 1
max_throw = 21

scores.each do |s|
  # 21球投げるパターン（10フレーム目にストイラクかスペアがある)
  if scores.length == max_throw
    if s == 'X'
      frame << 10
    else
      frame << s.to_i
    end
    if throw_count.even? && throw_count < 19
      frames << frame
      frame = []
    elsif throw_count == max_throw
      frames << frame
    end
  # 13-20球投げてかつ配列に['X']があるパターン
  elsif scores.include?('X') && 13 <= scores.length && scores.length <= 20
    if scores.length - throw_count > 2
      if s == 'X'
        frames << [10]
      else
        frame << s.to_i
      end
      if frame.length == 2
        frames << frame
        frame = []
      end
    elsif scores.length - throw_count < 3
      if s == 'X'
        frame << 10
      else
        frame << s.to_i
      end
      if frame.length == 3 && scores.length - throw_count == 0
        frames << frame
      elsif frame.length == 2 && (scores.length - throw_count).even?
        frames << frame
        frame = []
      end
    end
  elsif scores.length == 12
    if s == 'X' && throw_count < 10
      frames << [10]
    elsif s != 'X' && throw_count < 10
      frame << s.to_i
      if frame.length == 2
        frames << frame
        frame = []
      end
    else
      if s == 'X'
        frame << 10
      else
        frame << s.to_i
      end
    end
    if frame.length == 3
      frames << frame
    end
  # 9フレームまで全部ストライク、10フレーム目にストライクかスペアどちらもない
  elsif scores.length == 11
    if s == 'X' && throw_count < 10
      frames << [10]
    else
      frame << s.to_i
    end
    if frame.length == 2
      frames << frame
    end
  # 1回もストライク、スペアなし
  else
    frame << s.to_i
    if frame.length == 2
      frames << frame
      frame = []
    end
  end
  throw_count += 1
end

point = 0
frame_number = 0
max_frame = 9
frames.each do |frame|
  # 10フレーム目は足すのみ
  if frame_number < 9
    #次のフレームもストライク
    if frame[0] == 10 && frames[frame_number + 1][0] == 10
      if frame_number == 8
        point += frame[0] + frames[frame_number + 1][0] + frames[frame_number + 1][1]
      else
      point += frame[0] + frames[frame_number + 1][0] + frames[frame_number + 2][0]
      end
    #単発ストライク
    elsif frame[0] == 10
      point += 10 + frames[frame_number + 1][0] + frames[frame_number + 1][1]
    #スペア
    elsif frame.sum == 10
      point += frame.sum + frames[frame_number + 1][0]
    else
      point += frame.sum
    end
  elsif frame_number == max_frame
    point += frame.sum
  end
  frame_number += 1
end
p point
