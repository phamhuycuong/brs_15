require "rails_helper"

describe Category, type: :model do
  describe "relationship" do
    it "shoud have many books" do
      t = Category.reflect_on_association :books
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
  end

  describe "validation" do
    let(:category_short_name) {FactoryGirl.build :category, :with_short_name}
    let(:category_short_content) {FactoryGirl.build :category, :with_short_content}

    it "should validate name with minimum charater" do
      expect(category_short_name).to_not be_valid
    end

    it "should validate content with minimum charater" do
      expect(category_short_content).to_not be_valid
    end
  end
end
