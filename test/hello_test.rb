# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/hello'

class HelloTest < Minitest::Test
  def test_return_greeting
    assert_equal hello, 'hello world'
  end
end
