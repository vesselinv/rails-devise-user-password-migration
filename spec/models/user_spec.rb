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

    describe "#valid_password?" do
      it "converts legacy password" do
        old_password = subject.encrypted_password

        subject.valid_password?(subject.password).should be_true
        subject.reload.encrypted_password.should_not eq(old_password)
      end
    end
  end
end
