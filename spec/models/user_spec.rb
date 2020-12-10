require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new }

  let(:email) { 'username@email.com' }
  let(:password) { 'password' }

  let(:second_user) { User.new }

  it 'is valid with valid attributes' do
    subject.email = email
    subject.password = password
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.password = password
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.email = email
    expect(subject).to_not be_valid
  end
  
  it 'is not valid when the email is not unique' do
    subject.email = email
    subject.password = password
    subject.save
    second_user.email = email
    expect(second_user).to_not be_valid
  end
end
