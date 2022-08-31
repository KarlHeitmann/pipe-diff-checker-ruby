# frozen_string_literal: true

require 'diffy'
require 'anbt-sql-formatter/formatter'
require_relative 'pipe_diff_checker'

def test1
  string1 = <<~TXT
    Hello how are you
    I'm fine
    That's great
  TXT
  # "Hello how are you\nI'm fine\nThat's great\n"
  string2 = <<~TXT
    Hello how are you?
    I'm fine
    That's swell
  TXT
  # "Hello how are you?\nI'm fine\nThat's swell\n"
  puts Diffy::Diff.new(string1, string2)

  diff_instance = Diffy::SplitDiff.new(string1, string2, options = {})

  puts diff_instance.left
  puts diff_instance.right
end

pdc = PipeDiffChecker.new(File.open(ARGV[0], 'r').read, File.open(ARGV[1], 'r').read)
puts pdc.run

