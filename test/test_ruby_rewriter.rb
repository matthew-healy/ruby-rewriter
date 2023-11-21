# frozen_string_literal: true

require "test_helper"

class TestRubyRewriter < Minitest::Test
  def test_version_number_exists
    refute_nil ::RubyRewriter::VERSION
  end
end
