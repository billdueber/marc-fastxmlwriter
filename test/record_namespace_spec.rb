require "minitest_helper"
require "marc"
require "stringio"
require "nokogiri"

describe "#encode" do
  def record
    MARC::Reader.new(test_data("one.dat")).first
  end

  it "does not include xml declaration" do
    refute_match(%r{<\?xml}, MARC::FastXMLWriter.encode(record))
  end

  describe "with namespace" do
    it "includes schema location" do
      assert_match(%r{xsi:schemaLocation}, MARC::FastXMLWriter.encode(record, include_namespace: true))
    end

    it "includes namespace declaration" do
      assert_match(%r{xmlns}, MARC::FastXMLWriter.encode(record, include_namespace: true))
    end

    it "validates against marc21slim.xsd" do
      xsd = Nokogiri::XML::Schema.new(File.read(File.join(__dir__, "schema", "MARC21slim.xsd")))
      doc = Nokogiri::XML.parse(MARC::FastXMLWriter.encode(record, include_namespace: true))
      assert xsd.validate(doc)
    end
  end

  describe "without namespace" do
    it "is well-formed" do
      refute_nil Nokogiri::XML.parse(MARC::FastXMLWriter.encode(record))
    end
  end
end
