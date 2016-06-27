require 'rails_helper'

module TestTokenAuthenticable
  class Authenticable
    def self.before_save(*args)
    end

    include TokenAuth::Authenticatable
  end
end

RSpec.describe TokenAuth::Authenticatable do
  context "when included in a class" do
    let(:authenticable) { TestTokenAuthenticable::Authenticable.new }

    it_behaves_like "authenticable"
  end
end