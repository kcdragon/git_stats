class Commit::File
  include Mongoid::Document

  field :path, type: String

  embedded_in :commit
end
