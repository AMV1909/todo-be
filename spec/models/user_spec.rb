require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "associations" do
    it { is_expected.to have_many(:todos).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(1).is_at_most(50) }

    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(1).is_at_most(50) }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(50) }
    it { is_expected.to have_secure_password }

    it "approves a valid email" do
      user.email = "email@valid.com"

      expect(user).to be_valid
    end

    it "rejects an invalid email" do
      user.email = "invalid-email"

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("must be a valid email address")
    end

    it "rejects a duplicated email regardless of case" do
      create(:user, email: "taken@email.com")
      user.email = "TAKEN@email.com"

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "allows updating by sending only one param" do
      saved_user = create(:user)
      found_user = described_class.find(saved_user.id)

      expect(found_user.update(first_name: "John")).to be(true)
    end
  end

  describe "normalization" do
    it "downcases and strips email" do
      user = create(:user, email: "JohnDoe@example.com")

      expect(user.email).to eq("johndoe@example.com")
    end
  end

  describe "authentication" do
    let(:user) { create(:user, password: "password") }

    it "returns the user with the right password" do
      expect(user.authenticate("password")).to eq(user)
    end

    it "returns false with a wrong password" do
      expect(user.authenticate("wrong")).to eq(false)
    end
  end
end
