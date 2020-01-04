require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a first name, last name, email and password' do
    u = User.new(
      first_name: "Aaron",
      last_name: "Sumner",
      email: "tester@example.com",
      password: "dottle-nouveaupvil"
    )
    expect(u).to be_valid
  end

  it 'is invalid without a first name' do
    u = User.new(first_name: nil)
    u.valid?
    expect(u.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    u = User.new(last_name: nil)
    u.valid?
    expect(u.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid with an email address' do
    User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester@example.com",
      password: "dottleeeddddd-apoi"
    )
    u = User.new(
      first_name: "Jane",
      last_name: "Testr",
      email: "tester@example.com",
      password: "dottleeeddddd-apoi"
    )

    u.valid?
    expect(u.errors[:email]).to include("has already been taken")
  end
  
  it "returns a user's full name as a string" do
    u = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@example.com",
      password: "dottleeeddddd-apoi"
    )

    expect(u.name).to eq 'John Doe'
  end
end
