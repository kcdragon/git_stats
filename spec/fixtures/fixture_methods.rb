def create_repository(overrides = {})
  attrs = { path: '/path/to/repo' }.merge(overrides)
  Repository.create(attrs)
end

def create_commit(overrides = {})
  attrs = {
    repository_id: '1',
    ref: '1234',
    date: Time.now,
    author: {
      name: 'Mike Dalton',
      email: 'mdalton@email.com'
    },
    files: [
      { path: 'foo.rb' },
      { path: 'bar/baz.rb' }
    ]
  }.merge(overrides)
  Commit.create(attrs)
end
