require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

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
    u = FactoryBot.build(:user, first_name: nil)
    u.valid?
    expect(u.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    u = FactoryBot.build(:user, last_name: nil)
    u.valid?
    expect(u.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email address' do
    u = FactoryBot.build(:user, email: nil)
    u.valid?
    expect(u.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: "test@example.com")
    u = FactoryBot.build(:user, email: "test@example.com")

    u.valid?
    expect(u.errors[:email]).to include("has already been taken")
  end
  
  it "returns a user's full name as a string" do
    u = FactoryBot.build(:user, first_name: "John", last_name: "Doe")

    expect(u.name).to eq 'John Doe'
  end
end
