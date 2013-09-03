require 'spec_helper'

describe Repository do

  describe '.load' do
    subject { Repository }

    let(:git_base) do
      double(log: git_commits)
    end

    def git_diff(*files)
      entries = files.map { |f| double(path: f) }
      double(entries: entries)
    end

    let(:git_commits) do
      [double(sha: '1',
              date: Time.now,
              author: double(name: 'foo', email: 'bar'),
              diff_parent: git_diff('one', 'two')),
       double(sha: '2',
              date: Time.now,
              author: double(name: 'cad', email: 'cdr'),
              diff_parent: git_diff('three', 'four'))]
    end

    let(:path) { '/path/to/repository' }
    let!(:repository) { create_repository(path: path) }

    before(:each) do
      Git::Base.stub(new: git_base)
      subject.load(path)
    end

    it 'creates Commits' do
      git_commits.each do |commit|
        cursor = Commit.where(repository_id: repository.id,
                              ref: commit.sha,
                              "author.name" => commit.author.name,
                              "author.email" => commit.author.email,
                              date: commit.date)

        expect(cursor).to be_exists
        expect(cursor.first.files.count).to eq 2
      end
    end
  end

  describe 'validations' do
    it 'blank path is invalid' do
      Repository.new.should_not be_valid
    end
  end
end
