class Commit
  include Mongoid::Document

  field :repository_id, type: String
  field :ref, type: String

  validates_presence_of :ref
end
