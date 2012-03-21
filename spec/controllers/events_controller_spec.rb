require 'spec_helper'

describe EventsController do



  describe 'access controller' do
    it 'should redirect to sign in page' do
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it 'should redirect to sign in page' do
      delete :destroy
      response.should redirect_to(new_user_session_path)
    end

    it 'should redirect to sign in page' do
      put :update
      response.should redirect_to(new_user_session_path)
    end

  end

end
