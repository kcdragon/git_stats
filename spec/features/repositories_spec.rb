require 'spec_helper'

describe 'repositories' do
  before(:each) do
    Git.stub(open: double(log: []))
  end

  it 'new repository' do
    visit '/repositories/new'

    page.should have_content 'New Repository'

    fill_in 'repository_path', with: '/path/to/repo'
    click_on 'Load'

    page.should have_content '/path/to/repo has been successfully loaded.'
  end

  it 'new repository does not exist' do
    Repository.stub(:load).and_raise(StandardError)

    visit '/repositories/new'

    page.should have_content 'New Repository'

    fill_in 'repository_path', with: '/path/to/repo'
    click_on 'Load'

    page.should have_content '/path/to/repo does not exist.'
  end

  it 'display repository' do
    repository = create_repository

    visit "/repositories/#{repository.id}"

    page.should have_content repository.path
  end

  it 'displays all repositories' do
    repositories = [create_repository(path: 'one'),
                    create_repository(path: 'two')]

    visit '/repositories'

    repositories.map(&:path).each do |repository_path|
      page.should have_content repository_path
    end

    click_link repositories.first.path

    page.should have_content repositories.first.path
    page.should_not have_content repositories.second.path
  end
end
