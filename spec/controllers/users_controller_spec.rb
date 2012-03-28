require 'spec_helper'

describe UsersController do

  render_views

  describe 'events_for' do
    it 'authenticate user' do
      get 'events_for'
      response.should redirect_to(new_user_session_path)
    end

    describe 'for authenticated users' do
      before(:each) do
        @old_user = Factory(:user)
        @example_date = Factory.next(:calendar_date)
        @old_event = Factory(:event, :user => @old_user, :calendar_date => @example_date)
        @user = Factory(:user, :email => Factory.next(:email))
        sign_in(@user)
      end
      it 'should show success for date which not exist' do
        xhr :get, :events_for, :id => @old_user.id, :year => (@example_date+1).year, :month => (@example_date+1).month, :day => (@example_date+1).day
        response.should be_success
      end
      it 'should show event' do
        xhr :get, :events_for, :id => @old_user.id, :year =>@example_date.year, :month => @example_date.month, :day => @example_date.day

        response
      end
    end

  end

end
