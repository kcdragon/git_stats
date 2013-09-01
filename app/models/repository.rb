class Repository
  include Mongoid::Document

  field :path, type: String

  validates_presence_of :path

  def self.load(path)
    git = Git.open(path)
    repository = Repository.create(path: path)

    commits = git.log
    commits.each do |commit|
      Commit.create(repository_id: repository.id,
                    ref: commit.sha)
    end
  end
end
