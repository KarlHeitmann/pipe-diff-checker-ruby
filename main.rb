require 'diffy'

# Diffy::Diff.default_format = :html
# Diffy::Diff.default_format = :text
Diffy::Diff.default_format = :color

def test
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

test

