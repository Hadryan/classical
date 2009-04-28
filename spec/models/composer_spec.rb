require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Composer do
  fixtures :composers

  before(:each) do
    @valid_attributes = {
			:first_name => "joe",
      :last_name => "Simpson",
      :nationality => "Ar"
    }

		@composer = Composer.new
  end

  after(:all)  { Composer.delete(:all) }

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

  it "should be valid full_name" do
    @composer.attributes = @valid_attributes
    @composer.full_name.should eql 'Simpson, joe'
    @composer.first_name = nil;
    @composer.full_name.should eql 'Simpson'
    @composer.first_name = '';
    @composer.full_name.should eql 'Simpson'
    @composer.first_name = 'joe';
    @composer.last_name = nil;
    @composer.full_name.should eql 'joe'
    @composer.last_name = '';
    @composer.full_name.should eql 'joe'
    @composer.first_name = nil;
    @composer.last_name = nil;
    @composer.full_name.should eql ''
  end

  it "shoul find a composer by your full_name" do
    composer = composers(:one)
    Composer.find_by_full_name(composer.full_name).should have(1).things
    composer.first_name = 'Lisa'
    Composer.find_by_full_name(composer.full_name).should have(0).things
    composer.first_name = 'Homer'
    composer.last_name = 'Flanders'
    Composer.find_by_full_name(composer.full_name).should have(0).things
    composer.first_name = ''
    Composer.find_by_full_name(composer.full_name).should have(0).things
    composer.first_name = nil
    composer.last_name = 'Flanders'
    Composer.find_by_full_name(composer.full_name).should have(0).things
    composer.last_name = nil
    Composer.find_by_full_name(composer.full_name).should have(0).things
  end
end
