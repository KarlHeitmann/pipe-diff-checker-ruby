# frozen_string_literal: true

require 'diffy'
require 'anbt-sql-formatter/formatter'

# Diffy::Diff.default_format = :html
# Diffy::Diff.default_format = :text
Diffy::Diff.default_format = :color

def prettier_sql(src)
  rule = AnbtSql::Rule.new

  # Convert keywords to uppercase
  rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE

  # User defined additional functions:
  %w[count sum substr date].each { |func_name| rule.function_names << func_name.upcase }

  rule.indent_string = '    '

  formatter = AnbtSql::Formatter.new(rule)
  formatter.format(src)
end

def test2(string1, string2)
  puts string1, string2
  pretty_sql1 = prettier_sql(string1)
  pretty_sql2 = prettier_sql(string2)
  puts '////////////////////////'
  puts pretty_sql1
  puts '########################'
  puts pretty_sql2
  puts '::::::::::::::::::::::::'

  puts Diffy::Diff.new(pretty_sql1, pretty_sql2)
  diff_instance = Diffy::SplitDiff.new(pretty_sql1, pretty_sql2, options = {})
  puts diff_instance.left
  puts diff_instance.right
end

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

test1
test2 File.open(ARGV[0], 'r').read, File.open(ARGV[1], 'r').read

