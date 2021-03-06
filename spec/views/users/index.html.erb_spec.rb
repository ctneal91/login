# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               email: 'Email@email.com',
               password: 'password'
             ),
             User.create!(
               email: 'Email2@email.com',
               password: 'password'
             )
           ])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'Email@email.com'.to_s, count: 1
    assert_select 'tr>td', text: 'Email2@email.com'.to_s, count: 1
  end
end
