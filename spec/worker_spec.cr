require "./spec_helper"

describe Brium::Worker do
  it "creates a worker with default params" do
    worker = Brium::Worker.new(1, "johndoe@org.com")
    worker.id.should eq(1)
    worker.email.should eq("johndoe@org.com")
  end
end
