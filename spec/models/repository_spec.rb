require 'spec_helper'

describe Repository do

  describe '.load' do
    subject { Repository }

    let(:git_base) do
      double(log: git_commits)
    end

    let(:git_commits) do
      [double(sha: '1', author: double(name: 'foo', email: 'bar')),
       double(sha: '2', author: double(name: 'cad', email: 'cdr'))]
    end

    let(:path) { '/path/to/repository' }
    let!(:repository) { create_repository(path: path) }

    before(:each) do
      Git::Base.stub(new: git_base)
      subject.load(path)
    end

    it 'creates Commits' do
      git_commits.each do |commit|
        Commit.where(repository_id: repository.id,
                     ref: commit.sha,
                     :author.name => commit.author.name,
                     :author.email => commit.author.email).should be_exists
      end
    end
  end

  describe 'validations' do
    it 'blank path is invalid' do
      Repository.new.should_not be_valid
    end
  end
end
