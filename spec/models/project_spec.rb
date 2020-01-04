require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'can have many notes' do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
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

  describe 'late_status' do
    it 'is late when the due date is past today' do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end

    it 'is on time when the due date is today' do
      project = FactoryBot.create(:project_due_today)

      expect(project).not_to be_late
    end

    it 'is on time when the due date is in the future' do
      project = FactoryBot.create(:project_due_tomorrow)

      expect(project).not_to be_late
    end
  end
end