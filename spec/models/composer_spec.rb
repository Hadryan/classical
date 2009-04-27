require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Composer do
  before(:each) do
    @valid_attributes = {
			:first_name => "joe",
      :last_name => "Simpson",
      :nationality => "Ar"
    }

		@composer = Composer.new
  end

  it "should create a new instance given valid attributes" do
    Composer.create!(@valid_attributes)
  end

	it "should be invalid without a last_name" do
    @composer.attributes = @valid_attributes.except(:last_name)
    @composer.should_not be_valid
    @composer.errors.on(:last_name).should_not be nil
    @composer.should have(1).error_on(:last_name)
    @composer.last_name = "Simpson"
    @composer.should be_valid
  end
end
