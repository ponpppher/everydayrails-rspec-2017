require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @u = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "agetayasais"
    )
    @project = @u.projects.create(
      name: "Test Project"
    )
  end

  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note.",
      user: @u,
      project: @project
    )

    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = Note.new(
      message: nil
    )
    note.valid?

    expect(note.errors[:message]).to include("can't be blank")
  end

  # アウトラインを書く
  # 文字列に一致するメッセージを検索する
  describe 'search message for a term' do
    before do
      @note1 = @project.notes.create(
        message: "This is the first note",
        user: @u
      )

      @note2 = @project.notes.create(
        message: "This is the second note",
        user: @u
      )

      @note3 = @project.notes.create(
        message: "First, preheat the oven.",
        user: @u
      )
    end

    # 状態を書いていく
    # マッチする条件
    context 'when a match is found' do
      # 検索に一致するメモを返す
      it 'return notes that match the search term' do
        expect(Note.search("first")).to include(@note1, @note3)

        expect(Note.search("first")).not_to include(@note2)
      end
    end

    # 1件も見当たらない場合
    context 'when no match is found' do
      # 空のコレクションを返す
      it 'returns an empty collection when no results are found' do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end