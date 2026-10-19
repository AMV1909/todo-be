require 'rails_helper'

RSpec.describe Todo, type: :model do
  subject(:todo) { build(:todo) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(1).is_at_most(100) }

    it { is_expected.to validate_length_of(:description).is_at_most(500) }

    it "is not completed by default" do
      expect(described_class.new.completed).to be(false)
    end
  end

  describe "owned by" do
    it "returns only todos of the given user" do
      owner = create(:user)
      own_todo = create(:todo, user: owner)

      create(:todo)

      expect(described_class.owned_by(owner)).to contain_exactly(own_todo)
    end
  end
end
