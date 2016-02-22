#!/usr/bin/ruby
#encoding: utf-8
# -w is used to add "warning" result while interpreter compile the code

# this code is trying to implement three work as follow:
# 1. download the latest BYR menology (based on the sent time of the post)
# 2. Unzip the zip file and detect current mac resolution ratio
# 3. Choose the most compatible one and set it as the wallpaper
# For more:
# * should be capable to run each month and compare the month with current time,
#   if fitted, run this script.
# * TBD

require 'open-uri'
require 'pathname'

# Init config params
zip_dest_path = '/Users/kxu/Pictures/BYR-Team'
zip_file_name = zip_dest_path + 'Menology201602.zip'

# down file from BYR BBS
zip_file_down = open('http://bbs.byr.cn/att/Showcase/0/1358/399752')
IO.copy_stream(zip_file_down, zip_file_name)

zip_extract_path = 'Menology_201602'
pwd_info = Pathname.new(File.dirname(__FILE__)).realpath.to_s
# unzip via 7zip command at CLI
## first decompress the zip file using 7z, rubyzip is not working right.
cli_cmd = '7z e -o' + zip_extract_path + ' ' + zip_file_name
system( cli_cmd )
## second move the unzipped dir to dest path
cli_cmd = 'mv ' + pwd_info + '/' + zip_extract_path + ' ' + zip_dest_path
system( cli_cmd )
# get current screen resolution & choose the one most fit to set as wallpaper
Dir.foreach(zip_dest_path + '/' + zip_extract_path) { |file_name|
  puts file_name
}
cli_cmd = "osascript -e 'tell application " + '"System Events" to set picture of every desktop to ("' + zip_dest_path + '/' + zip_extract_path + '/' + img_name + '" as POSIX file as alias)' + "'"
#system(cli_cmd)
puts cli_cmd

puts 'Done.'
