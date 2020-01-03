require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'does not allow duplicate project name per user' do
    u = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottllele"
    )
    u.projects.create(
      name: "Test Project"
    )

    new_p = u.projects.build(
      name: "Test Project"
    )
    new_p.valid?

    expect(new_p.errors[:name]).to include("has already been taken")
  end

  it 'allows two users to share a project name' do
    u = User.create(
      first_name: "Joe",
      last_name: "tester",
      email: "joetester@example.com",
      password: "dottole-dao"
    )
    u.projects.create(
      name: "Test Project"
    )

    other_user = User.create(
      first_name: "Jane",
      last_name: "tester",
      email: "Janetester@example.com",
      password: "dottole-dao"
    )

    other_project = other_user.projects.build(
      name: "Test Project"
    )

    expect(other_project).to be_valid
  end
end
