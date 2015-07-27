require "rails_helper"

describe Admin::CategoriesController, type: :controller do
  describe "GET #index" do
    let(:category_list) {FactoryGirl.create_list :category, 6}
    before {get :index}

    it "should loads all of the category" do
      expect(assigns(:categories)).to match_array category_list
    end

    it "should renders the index template" do
      expect(response).to render_template("index")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    let(:category) {FactoryGirl.create :category}
    before {get :show, id: category.id}

    it "should loads the category" do
      expect(assigns(:category)).to match category
    end

    it "should renders the show template" do
      expect(response).to render_template("show")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    before {get :new}

    it "should new the category" do
      expect(assigns(:category)).to_not be nil
    end

    it "should renders the show template" do
      expect(response).to render_template("new")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "when submit a valid category" do
      let(:category_valid) {FactoryGirl.build :category}
      before {post :create, category: category_valid.attributes}

      it "should create a new category with strong parameter" do
        expect(Category.count).to eq 1
        expect([Category.last.name, Category.last.content]).
          to eq [category_valid.name, category_valid.content]
      end

      it "should redirect to category after success save" do
        expect(response).to redirect_to [:admin, Category.last]
      end

      it "should notice success create new category" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when submit an invalid category" do
      let(:category_invalid) {FactoryGirl.build :category, :with_short_name}
      before {post :create, category: category_invalid.attributes}

      it "should not create a new category" do
        expect(Category.count).to eq 0
      end

      it "should render new" do
        expect(response).to render_template("new")
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #edit" do
    let(:category) {FactoryGirl.create :category}
    before {get :edit, id: category.id}

    it "should find the category with id" do
      expect(assigns[:category]).to eq category
    end

    it "should render edit" do
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    let(:category) {FactoryGirl.create :category}
    let(:category_valid) {FactoryGirl.build :category}
    let(:category_invalid) {FactoryGirl.build :category, :with_short_name}

    context "when submit a valid category" do
      before {put :update, id: category.id, category: category_valid.attributes}

      it "should update category with strong parameter" do
        category = Category.find 1
        expect([category.name, category.content]).
          to eq [category_valid.name, category_valid.content]
      end

      it "should redirect to category after success update" do
        expect(response).to redirect_to [:admin, category]
      end

      it "should notice success update new category" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when submit an invalid category" do
      before {patch :update, id: category.id, category: category_invalid.attributes}

      it "should not update category" do
        category = Category.find 1
        expect([category.name, category.content]).
          to_not eq [category_invalid.name, category_invalid.content]
      end

      it "should render edit" do
        expect(response).to render_template("edit")
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:category) {FactoryGirl.create :category}
    before {delete :destroy, id: category.id}

    it "should find the category with id" do
      expect(assigns[:category]).to eq category
    end

    it "should delete category" do
      expect(Category.count).to eq 0
    end

    it "should redirect to category after success update" do
      expect(response).to redirect_to [:admin, :categories]
    end

    it "should flass notice destroy category" do
      expect(flash[:notice]).to be_present
    end

  end
end
