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
    end
  end

  it 'displays commit' do
    visit repository_commits_path(repository)

    click_link commits.first.ref

    page.should have_content commits.first.ref
  end
end
