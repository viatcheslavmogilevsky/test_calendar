require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @attr = {:content => 'event content', :calendar_date => Date.new(1996,3,4)}
  end

  it "event with user should be valid" do
    @user.events.create!(@attr)
  end

  it "event without user shoul not be valid" do
    Event.new(@attr).should_not be_valid
  end

end
