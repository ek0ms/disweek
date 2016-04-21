require 'rails_helper'

describe User do
  describe "#from_omniauth" do
    it "creates user in database from omniauth" do
      auth = OmniAuth.config.mock_auth[:instagram]
      User.from_omniauth(auth)
      expect(User.first.nickname).to eq(auth.info.nickname)
    end
  end
end
