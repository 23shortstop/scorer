require 'rails_helper'

shared_examples "authenticable" do
  let(:token) { FFaker::Lorem.characters(32) }

  describe ".find_by_authentication_token" do

    before do
      allow(authenticable.class).to receive(:find)
      allow(authenticable.class).to receive(:token_val)
    end

    it "have to call token_val" do
      expect(authenticable.class).to receive(:token_val)
      authenticable.class.find_by_authentication_token(token)
    end

    context "token was found in redis" do
      before do
        allow(authenticable.class).to receive(:token_val).and_return(:token)
      end

      it "have to call .find" do
        expect(authenticable.class).to receive(:find)
        authenticable.class.find_by_authentication_token(token)
      end
    end

    context "token was not found in redis" do
      before do
        allow(authenticable.class).to receive(:token_val).and_return(nil)
      end

      it "have not to call .find" do
        expect(authenticable.class).to_not receive(:find)
        authenticable.class.find_by_authentication_token(token)
      end
    end
  end

  describe ".authenticate" do
    before do
      TestTokenAuthenticable::Authenticable.class_variable_set(:@@credentials, [:username, :password])
    end

    def credentials
      [FFaker::Internet.email, FFaker::Internet.password]
    end

    it "have to find entity by username and password" do
      expect(authenticable.class).to receive(:send).with("find_by_username_and_password", kind_of(String), kind_of(String))
      authenticable.class.authenticate(*credentials)
    end

    # it "have to raise an exception "
  end
end