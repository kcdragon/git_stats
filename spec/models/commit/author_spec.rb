require 'spec_helper'

describe Commit::Author do
  it { should be_embedded_in(:commit).of_type(Commit) }
end
