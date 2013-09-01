require 'spec_helper'

describe Repository do

  describe '.load' do
    subject { Repository }

    let(:git_base) do
      double(log: git_commits)
    end

    let(:git_commits) do
      [double(sha: '1'), double(sha: '2')]
    end

    let(:path) { '/path/to/repository' }

    before(:each) do
      Git::Base.stub(new: git_base)
      subject.load(path)
    end

    it 'creates Repository' do
      Repository.where(path: path).should be_exists
    end

    it 'creates Commits' do
      repository = Repository.where(path: path).first
      git_commits.each do |commit|
        Commit.where(repository_id: repository.id,
                     ref: commit.sha).should be_exists
      end
    end
  end

  describe 'validations' do
    it 'blank path is invalid' do
      Repository.new.should_not be_valid
    end
  end
end