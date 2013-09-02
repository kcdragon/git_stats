require 'spec_helper'

describe Commit do
  describe 'validations' do
    let(:repository) { create_repository }

    it 'no ref is invalid' do
      Commit.new(repository_id: repository.id).should_not be_valid
    end

    it 'no repository id is invalid' do
      Commit.new(ref: '1').should_not be_valid
    end

    it 'no existent repository for repository id is invalid' do
      Commit.new(repository_id: '1', ref: '1').should_not be_valid
    end
  end
end
