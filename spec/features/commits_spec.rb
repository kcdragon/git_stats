require 'spec_helper'

describe 'commits' do

  let!(:repository) { create_repository }
  let!(:commits) { [create_commit(repository_id: repository.id, ref: '123'),
                    create_commit(repository_id: repository.id, ref: '456')] }

  it 'display all commits for repository' do
    visit repository_commits_path(repository)

    commits.each do |commit|
      page.should have_content commit.ref
      page.should have_content commit.author.name
      page.should have_content commit.author.email
      page.should have_content commit.date
    end
  end

  it 'displays commit' do
    commit = commits.first
    visit repository_commits_path(repository)

    click_link commit.ref

    page.should have_content commit.ref
    commit.files.map(&:path).each do |path|
      page.should have_content path
    end
  end
end
