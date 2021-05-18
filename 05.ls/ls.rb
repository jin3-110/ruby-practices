#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

option = ARGV.getopts('a', 'l', 'r')

# ファイルの読み込み
receive_files = Dir.glob('*')
receive_files = Dir.glob('*', File::FNM_DOTMATCH) if option['a']
receive_files = Dir.glob('*').reverse if option['r']
receive_files = Dir.glob('*', File::FNM_DOTMATCH).reverse if option['r'] && option['a']

# 3列表示メソッド
def file_display(file)
  case file.length % 3
  when 1
    file << '' << ''
  when 2
    file << ''
  end
  file_space = file.max_by(&:length).length + 7
  file.each do |element|
    element = +element
    element << ' ' * (file_space - element.length)
  end
  split_count = (file.length + 2) / 3
  split_files = file.each_slice(split_count).to_a
  output_files = split_files.transpose
  output_files.each_with_index do |element, index|
    element[2] += "\n" if index < split_count
  end
  puts output_files.join
end

# 出力プログラム
if option['l']
  def permission(mode)
    permission_replacement = {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }
    mode.map { |p| permission_replacement[p] }.join
  end

  block = receive_files.sum { |b| File.stat(b).blocks }
  puts "total #{block}"

  receive_files.each do |receive_file|
    file = File::Stat.new(receive_file)
    file_type = file.ftype.slice(0)
    file_type = '-' if file.ftype.slice(0) == 'f'
    file_mode = permission(file.mode.to_s(8)[-3, 3].chars)
    file_link = file.nlink
    file_uid = Etc.getpwuid(File.stat(receive_file).uid).name
    file_gid = Etc.getgrgid(File.stat(receive_file).gid).name
    file_size = file.size
    file_time = file.mtime.strftime('%m %d %R')
    file_name = receive_file
    print "#{file_type}#{file_mode} #{file_link.to_s.rjust(2)} #{file_uid} #{file_gid} #{file_size.to_s.rjust(4)} #{file_time} #{file_name}\n"
  end
else
  file_display(receive_files)
end
