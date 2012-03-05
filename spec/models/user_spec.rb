
require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Example User",
	      :email => "user@example.com",
              :password => "foobar",
              :password_confirmation => "foobar"
		}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should reject names that are too long" do
    long_name = "a"*51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end


  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end


  describe "event associations" do

    before(:each) do
      @user = User.create(@attr)
      @ev1 = Factory(:event, :user => @user, :created_at => 1.day.ago, :calendar_date => 5.day.ago)
      @ev2 = Factory(:event, :user => @user, :created_at => 1.hour.ago, :calendar_date => 1.year.ago)
    end

    it "should have a events attribute" do
      @user.should respond_to(:events)
    end

    it "should have the right events in the right order" do
      @user.events.should == [@ev1, @ev2]
    end


  end


      describe "password validations" do

 	   it "should require a password" do
	      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
 	   end

	   it "should require a matching password confirmation" do
   	     User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
   	   end

  	   it "should reject short passwords" do
     	     short = "a" * 5
    	     hash = @attr.merge(:password => short, :password_confirmation => short)
             User.new(hash).should_not be_valid
  	   end

 	   it "should reject long passwords" do
 	     long = "a" * 41
 	     hash = @attr.merge(:password => long, :password_confirmation => long)
  	     User.new(hash).should_not be_valid
	   end

      end







end
