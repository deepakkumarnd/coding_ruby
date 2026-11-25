#!/usr/bin/env ruby
def extract_env(input)
  vars = []
  patterns = [
    /(ENV\[['"](?<name>\w+)['"]\])/, # rubocop:disable Lint/MixedRegexpCaptureTypes
    /ENV.fetch\(['"](?<name>\w+)['"]\)/,
    /ENV.fetch\(['"](?<name>\w+)['"],/
  ]
  patterns.each do |pat|
    matches = input.scan(pat)
    vars.push(matches.flatten) if matches.length.positive?
  end
  vars
end

vars = []

ARGF.each_line do |line|
  vars.push(extract_env(line))
end

puts vars.flatten.sort.uniq
