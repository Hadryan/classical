require 'spec_helper'

describe Album do
  it "should return true if the album was owned by a user" do
    @album = Album.new
    @album.owned_by?(User.new).should be_false
  end
end

