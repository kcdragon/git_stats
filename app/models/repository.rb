class Repository
  include Mongoid::Document

  field :path, type: String

  validates_presence_of :path

  def self.load(path)
    git = Git.open(path)
    repository = Repository.where(path: path).first

    commits = git.log
    commits.each do |commit|
      Commit.create(repository_id: repository.id,
                    ref: commit.sha,
                    date: commit.date).tap do |c|
        c.build_author(name: commit.author.name,
                       email: commit.author.email)
        commit.diff_parent.entries.each do |entry|
          c.files.build(path: entry.path)
        end
        c.save
      end

    end
    repository
  end
end
