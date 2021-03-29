#!/usr/bin/env ruby

require "date"
require "optparse"

# コマンドのオプションから受け取った引数をmonth_yearに代入
month_year = ARGV.getopts("m:", "y:")

# 配列month_yearの要素をmonthとyearで区別しやすくする
month = month_year["m"]
year = month_year["y"]

# -mオプションの指定がない場合は、今月を表示
if month == nil
  month = Date.today.month
end

# -yオプションの指定がない場合は、今年を表示
if year == nil
  year = Date.today.year
end

# 曜日の配列を用意
one_weeks = ["日", "月", "火", "水", "木", "金", "土"]

# 指定した月の初日を求める
first_day = Date.new(year.to_i, month.to_i, 1).day

# 指定した月の最終日を求める
last_day = Date.new(year.to_i, month.to_i, -1).day

# 1ヶ月分の日数
month_days = first_day..last_day

# 初日の曜日を確認する
start_first_day = Date.new(year.to_i, month.to_i, first_day).wday

# 初日の開始位置を決める
start_position = start_first_day

# カレンダーの標準出力部分
# 月と年
puts "#{month}月 #{year}".center(20)

# 曜日
puts one_weeks.join(" ")

# 初日前の空白部分を作る
space = "   " * start_first_day
print space

# 日付を表示
month_days.each do |days|
  # stringクラスのrjustメソッドを使って右端揃え
  print days.to_s.rjust(2)
  # 文字の右に半角スペースを1つ分用意
  print " "
  start_position += 1
  # 7回目（土）になったら改行する
  if start_position % 7 == 0
    puts ""
  end
end

# 最終日の次に %が表示されるのをなくす
puts ""
