module ControllerMacros
  def login_legacy_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:legacy_user)
      user.confirm!
      sign_in user
    end
  end
end
