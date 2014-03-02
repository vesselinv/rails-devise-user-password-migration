require "spec_helper"

describe DeviseController do

  describe "Legacy Password User" do
    login_legacy_user

    its(:current_user) do
      should_not  be_nil
      should      be_instance_of User
    end
  end

end
