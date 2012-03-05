require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @attr = {:content => 'event content', :calendar_date => Date.new(1996,3,4)}
  end

  it "event should be valid" do
    @user.events.create!(@attr)
  end


end
