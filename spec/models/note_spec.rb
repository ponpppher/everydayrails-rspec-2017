require 'rails_helper'

RSpec.describe Note, type: :model do
  # 検索に一致するメモを返す
  it 'return notes that match the search term' do
    u = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "agetayasais"
    )

    project = u.projects.create(
      name: "Test Project"
    )

    note1 = project.notes.create(
      message: "This is the first note",
      user: u
    )

    note2 = project.notes.create(
      message: "This is the second note",
      user: u
    )

    note3 = project.notes.create(
      message: "First, preheat the oven.",
      user: u
    )

    expect(Note.search("first")).to include(note1, note3)

    expect(Note.search("first")).not_to include(note2)
  end

  it 'returns an empty collection when no results are found' do
    u = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "agetayasais"
    )

    project = u.projects.create(
      name: "Test Project"
    )

    note1 = project.notes.create(
      message: "This is the first note",
      user: u
    )

    note2 = project.notes.create(
      message: "This is the second note",
      user: u
    )

    note3 = project.notes.create(
      message: "First, preheat the oven.",
      user: u
    )

    expect(Note.search("message")).to be_empty
  end
end
