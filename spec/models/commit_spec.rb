require 'spec_helper'

describe Commit do
  describe 'validations' do
    it 'no ref is invalid' do
      Commit.new.should_not be_valid
    end
  end
end
