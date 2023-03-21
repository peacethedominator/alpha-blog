require 'rails_helper'

describe User do
    before(:each) do
        @user = User.new
    end
    it 'sholud have an username' do
        @user.email = "abc@example.com"
        expect(@user.username).to be_falsey
    end
    it 'sholud have an username with required length' do
        @user.username = "abcde"
        expect(@user.username.length).to be_between(3,25)
    end
    it 'should have a email' do
        @user.username = "abcde"
        expect(@user.email).to be_falsey
    end
    it 'sholud have an username with required length' do
        @user.email = "abc@example.com"
        expect(@user.email.length).to be < 105
    end
end
