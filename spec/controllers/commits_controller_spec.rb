require 'spec_helper'

describe CommitsController do

  let(:repository) { create_repository }

  let!(:commits) do
    [create_commit(repository_id: repository.id),
     create_commit(repository_id: repository.id)]
  end

  describe '#index' do
    before(:each) { get :index, repository_id: repository.id }

    it 'assigns commits' do
      expect(assigns(:commits)).to match_array commits
    end

    it_behaves_like 'http response', 'index'
  end

  describe '#show' do
    before(:each) { get :show, repository_id: repository.id, id: commits.first.id }

    it 'assigns commit' do
      expect(assigns(:commit)).to eq commits.first
    end

    it_behaves_like 'http response', 'show'
  end
end
