def create_repository(overrides = {})
  attrs = { path: '/path/to/repo' }.merge(overrides)
  Repository.create(attrs)
end

def create_commit(overrides = {})
  attrs = { repository_id: '1', ref: '1234' }.merge(overrides)
  Commit.create(attrs)
end
