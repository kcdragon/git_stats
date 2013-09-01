require 'spec_helper'

describe RepositoriesController do

  let!(:repositories) do
    [Repository.create(path: 'one'),
     Repository.create(path: 'two')]
  end

  shared_examples_for 'http response' do |template|
    it 'success' do
      expect(response).to be_success
    end

    it 'status code of 200' do
      expect(response.status).to eq 200
    end

    it "renders #{template} template" do
      expect(response).to render_template template
    end
  end

  describe '#index' do
    before(:each) { get :index }

    it 'assigns repositories' do
      expect(assigns(:repositories)).to match_array repositories
    end

    it_should_behave_like 'http response', 'index'
  end

  describe '#show' do
    let(:repository) { repositories.first }

    before(:each) { get :show, id: repository.id }

    it 'assigns repository' do
      expect(assigns(:repository)).to eq repository
    end

    it_should_behave_like 'http response', 'show'
  end

  describe '#new' do
    before(:each) { get :new }

    it 'assigns new repository' do
      expect(assigns(:repository)).to be_kind_of(Repository)
      expect(assigns(:repository)).to be_new_record
    end

    it_should_behave_like 'http response', 'new'
  end

  describe '#create' do
    before(:each) { post :create, params }

    context 'when params are valid' do
      let(:params) do
        { path: '/path' }
      end

      it 'creates repository' do
        expect(Repository.where(path: params[:path])).to be_exists
      end

      it 'flashes success' do
        expect(flash[:success]).to be_present
      end

      it_should_behave_like 'http response', 'index'
    end

    context 'when params are not valid' do
      let(:params) { {} }

      it 'does not create repository' do
        expect(Repository.where(path: params[:path])).to_not be_exists
      end

      it 'repository has errors' do
        expect(assigns(:repository)).to have(1).error_on(:path)
      end

      it_should_behave_like 'http response', 'new'
    end
  end
end
