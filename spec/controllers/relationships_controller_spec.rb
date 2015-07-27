require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  let(:current_user){FactoryGirl.create(:user)}
  let(:other_user){FactoryGirl.create(:user)}

  describe "POST create" do
    before do
      sign_in current_user
    end

    it "create a new Relationship" do
      expect{xhr :post, :create, followed_id: other_user.id}.to change(Relationship, :count).by(1)
    end
  end

  describe "DELETE destroy" do
    before do
      sign_in current_user
      current_user.follow other_user
    end

    it "destroy a relationship" do
      expect{xhr :delete, :destroy, id: Relationship.find_by(followed_id: other_user.id)}.to change(Relationship, :count).by(-1)
    end
  end
end
