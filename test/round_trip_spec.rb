require 'minitest_helper'
require 'marc'

describe "loads" do
  it "loads the constant" do
    assert defined? MARC::FastXMLWriter
  end
end

  