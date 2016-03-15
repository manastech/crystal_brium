require "./spec_helper"

describe Brium::Entry do
  describe "keyword" do
    it "gets without colon" do
      entry = Brium::Entry.new(1, 2, "foo", Time.now, 8.0)
      entry.keyword.should eq("foo")
    end

    it "gets with colon" do
      entry = Brium::Entry.new(1, 2, "foo: bar", Time.now, 8.0)
      entry.keyword.should eq("foo")
    end

    it "gets with colon and does downcase" do
      entry = Brium::Entry.new(1, 2, "foo: bar", Time.now, 8.0)
      entry.keyword.should eq("foo")
    end
  end
end
