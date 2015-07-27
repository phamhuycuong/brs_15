require "rails_helper"

RSpec.describe Admin::BooksController, type: :controller do
  before do
    allow(controller).to receive(:required_admin).and_return(true)
  end

  describe "GET #index" do
    before do
      get :index
    end

    it {expect(response).to render_template :index}
    it {expect(response).to have_http_status 200}
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, book: FactoryGirl.attributes_for(:book)
      end

      it "create the book" do
        expect(Book.count).to eq(1)
      end

      it "redirect to admin book index page" do
        expect(response).to redirect_to [:admin, :books]
      end

      it "after create flash a message" do
        expect(flash[:success]).to eq("Success created book!.")
      end
    end

    context "with invalid attributes" do
      before do
        post :create, book: FactoryGirl.attributes_for(:book, title: nil)
      end

      it "doesn't create the book" do
        expect(Book.count).to eq(0)
      end

      it "re-renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:book_valid){FactoryGirl.create(:book)}
    context "with valid attributes" do
      before(:each) do
        patch :update, id: book_valid.id, book: book_valid.attributes
      end

      it "update the book" do
        expect(assigns(:book)).to eq(book_valid)
      end

      it "redirect to admin book index page" do
        expect(response).to redirect_to [:admin, :books]
      end

       it "after update flash a message" do
        expect(flash[:success]).to eq("Success updated book!.")
      end
    end

    let(:book_invalid){FactoryGirl.create(:book, title: nil)}
    context "with invalid attributes" do
      before(:each) do
        patch :update, id: book_invalid.id, book: book_invalid.attributes
      end

      it "doesn't update the book" do
        expect(assigns(:book)).to eq(book_invalid)
      end

      it "re-render to edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let(:book){FactoryGirl.create(:book)}
    before(:each) do
      delete :destroy, id: book.id, book: book.attributes
    end

    it "delete the book" do
        expect(assigns(:book).destroyed?).to be true
      end

    it "redirect to admin book index page" do
      expect(response).to redirect_to [:admin, :books]
    end

    it "after delete flash a success message" do
      expect(flash[:success]).to eq("Success destroyed book!.")
    end
  end
end
