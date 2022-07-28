$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "marc/fastxmlwriter"

require "minitest"
require "minitest/spec"
require "minitest/autorun"

def test_data_dir
  File.join(__dir__, "test_data")
end

def test_data(relative_path)
  File.join(__dir__, "test_data", relative_path)
end
