require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do
  let(:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false) }

  describe 'GET index' do
    login_user

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns [my_wiki] to @wikis' do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe 'GET new' do
    login_user
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new
      expect(response).to render_template :new
    end

    it 'instantiates @wiki' do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe 'POST create' do
    login_user
    it 'increases the number of Wiki by 1' do
      expect { post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false } }.to change(Wiki, :count).by(1)
    end

    it 'assigns the new wiki to @wiki' do
      post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it 'redirects to the new wiki' do
      post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe 'GET show' do
    login_user
    it 'returns http success' do
      get :show, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, id: my_wiki.id
      expect(response).to render_template :show
    end

    it 'assigns my_wiki to @wiki' do
      get :show, id: my_wiki.id
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe 'GET edit' do
    login_user
    it 'returns http success' do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      get :edit, id: my_wiki.id
      expect(response).to render_template :edit
    end

    it 'assigns wiki to be updated @wiki' do
      get :edit, id: my_wiki.id
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
      expect(wiki_instance.private).to eq my_wiki.private
    end
  end

  describe 'PUT update' do
    login_user
    it 'updates wiki with expected attributes' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body, private: false }
      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
      expect(updated_wiki.private).to eq my_wiki.private
    end

    it 'redirects to the updated wiki' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body, private: false }
      expect(response).to redirect_to my_wiki
    end
  end

  describe 'DELETE destroy' do
    login_admin
    it 'deletes the wiki' do
      delete :destroy, id: my_wiki.id
      count = Wiki.where(id: my_wiki.id).size
      expect(count).to eq 0
    end

    it 'redirects to wikis index' do
      delete :destroy, id: my_wiki.id
      expect(response).to redirect_to wikis_path
    end
  end
end
