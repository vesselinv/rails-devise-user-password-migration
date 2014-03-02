require 'spec_helper'

describe User do
  context "standard user" do
    subject { create(:user) }

    it { should be_valid }
  end

  context "legacy password" do
    subject { create(:legacy_user) }

    it { should be_valid }

    its(:legacy_password) { should be_true }

    describe ".legacy_password" do
      it "returns MD5 hash" do
        User.legacy_password(subject.password).should eq(subject.encrypted_password)
      end
    end
end
