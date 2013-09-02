require 'spec_helper'

describe RepositoriesController do
  before(:each) do
    Git.stub(open: double(log: []))
  end

  describe '#index' do
    let!(:repositories) do
      [Repository.create(path: 'one'),
       Repository.create(path: 'two')]
    end

    before(:each) { get :index }

    it 'assigns repositories' do
      expect(assigns(:repositories)).to match_array repositories
    end

    it_should_behave_like 'http response', 'index'
  end

  describe '#show' do
    let(:repository) { Repository.create(path: 'one') }

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
    context 'when params are valid' do
      let(:params) do
        { repository: { path: '/path' } }
      end

      before(:each) { post :create, params }

      it 'creates repository' do
        expect(Repository.where(path: params[:repository][:path])).to be_exists
      end

      it 'flashes success' do
        expect(flash[:success]).to be_present
      end

      it 'status is redirect' do
        expect(response.status).to eq 302
      end
    end

    context 'when path is not present' do
      let(:params) { { repository: {} } }

      before(:each) { post :create, params }

      it 'does not create repository' do
        expect(Repository.count).to eq 0
      end

      it 'repository has errors' do
        expect(assigns(:repository)).to have(1).error_on(:path)
      end

      it_should_behave_like 'http response', 'new'
    end

    context 'when path does not exist' do
      let(:params) { { repository: { path: '/does/not/exist' } } }

      before(:each) do
        Repository.stub(:load).and_raise(StandardError)
        post :create, params
      end

      it 'repository does not exist' do
        expect(Repository.count).to eq 0
      end

      it 'flashes error' do
        expect(flash[:error]).to be_present
      end

      it_should_behave_like 'http response', 'new'
    end
  end
end
