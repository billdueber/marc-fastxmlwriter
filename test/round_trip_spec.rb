require 'minitest_helper'
require 'marc'
require 'stringio'

describe "loads" do
  it "loads the constant" do
    assert defined? MARC::FastXMLWriter
  end
end



ROUND_TRIP_FILES = Dir.glob(test_data_dir + '/*')

describe "round-trip tests" do
  it "round-trips to/from xml and MARC::Record" do
    ROUND_TRIP_FILES.each do |filename|
      MARC::Reader.new(filename).each_with_index do |r1, i|
        xml = MARC::FastXMLWriter.single_record_document(r1)
        s = StringIO.new(xml)
        r2 = MARC::XMLReader.new(s).first
        assert_equal r1, r2, "File #{filename} record #{i}"
      end
    end
  end
end
