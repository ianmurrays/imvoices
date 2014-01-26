require 'spec_helper'

describe UsersController do
  context "authentication" do
    describe "#authenticate" do
      let(:password) { "john123" }
      let(:user)     { create :user, password: password, password_confirmation: password }

      describe "with the correct credentials" do
        before(:each) do
          post :authenticate, user: { email: user.email, password: password }, format: :json
        end

        it { response.response_code.should == 200 }

        it "should return a JSON Web Token" do
          json = JSON.parse response.body
          json["token"].should_not be_nil
          json["token"].should == JWT.encode({user_id: user.id}, Figaro.env.jwt_secret)
        end
      end

      describe "with the incorrect credentials" do
        before(:each) do
          post :authenticate, user: { email: user.email, password: "incorrect" }, format: :json
        end

        it { response.response_code.should == 401 }

        it "should respond with an emtpy body" do
          response.body.strip.should be_empty
        end
      end
    end
  end
end
