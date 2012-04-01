require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @attr = {:content => 'event content', :calendar_date => Date.new(1996,3,4), :repeat => 0}
  end

  it "event with user should be valid" do
    @user.events.create!(@attr)
  end

  it "event without user shoul not be valid" do
    Event.new(@attr).should_not be_valid
  end

  it "if event happens every day then calendar_dat may be blank" do
    @user.events.new(@attr.merge(:repeat => 4, :calendar_date => nil)).should be_valid
  end


end
