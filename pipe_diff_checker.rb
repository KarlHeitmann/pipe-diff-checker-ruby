# frozen_string_literal: true

require 'diffy'
require 'anbt-sql-formatter/formatter'

# Initialize it with some strings, and once it is run it will pipe the string to pretty SQL,
# then print the diff.
#
class PipeDiffChecker
  attr_reader :str1, :str2, :rule, :formatter

  # attr_reader :str1, :str2

  def initialize(stri1, stri2)
    @str1 = stri1
    @str2 = stri2

    # Diffy::Diff.default_format = :html
    # Diffy::Diff.default_format = :text
    Diffy::Diff.default_format = :color

    @rule = AnbtSql::Rule.new
    # Convert keywords to uppercase
    @rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE

    # User defined additional functions:
    %w[count sum substr date].each { |func_name| rule.function_names << func_name.upcase }

    @rule.indent_string = '    '

    @formatter = AnbtSql::Formatter.new(rule)
    # formatter.format(src)
  end

  def run
    sql1 = pretty_sql(@str1)
    sql2 = pretty_sql(@str2)
    Diffy::Diff.new(sql1, sql2)
  end

  def pretty_sql(sql)
    @formatter.format(sql)
  end
end
