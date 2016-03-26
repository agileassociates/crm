require 'rails_helper'
require 'support/violate_check_constraint_matcher'

describe User do
  describe "email" do
    let(:user) {
      User.create!(email: "foo@example.com", password: "qwertyup", password_confirmation: "qwertyup")
    }
    it "absolutely prevents invalid email addresses" do
      expect {
        user.update_attribute(:email, "foo@bar.com")
      }.to raise_error(ActiveRecord::StatementInvalid, /email_must_be_company_email/i)
    end
  end
end