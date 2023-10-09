require 'rails_helper'

RSpec.feature 'User Index Page' do
  before do
    User.create(name: 'Pikachu', photo: 'https://www.pngegg.com/en/png-wgjix')
    User.create(name: 'Meowth', photo: 'https://www.pngegg.com/en/png-sigeb')
    User.create(name: 'Squirtle ', photo: 'https://www.pngegg.com/en/png-bsdir')
    User.create(name: 'Charmander', photo: 'https://www.pngegg.com/en/png-bntxq')
    User.create(name: 'Pysduck', photo: 'https://www.pngegg.com/en/png-bnagx')
  end

  scenario 'I can see the username of all other users.' do
    visit users_path

    expect(page).to have_content('Pikachu')
    expect(page).to have_content('Squirtle')
    expect(page).to have_content('Pysduck')
  end

  scenario 'I can see the profile picture for each user.' do
    visit users_path

    expect(page).to have_selector('img[src="https://www.pngegg.com/en/png-wgjix"]')
    expect(page).to have_selector('img[src="https://www.pngegg.com/en/png-sigeb"]')
    expect(page).to have_selector('img[src="https://www.pngegg.com/en/png-bntxq"]')
  end

  scenario 'I can see the number of posts each user has written.' do
    user1 = User.find_by(name: 'Pikachu')
    user2 = User.find_by(name: 'Meowth')
    Post.create(author: user1, title: 'First Post', text: 'I am Pikachu')
    Post.create(author: user2, title: 'Second Post', text: 'I Love Meowth')
    visit users_path

    expect(page).to have_content(user1.posts_counter)
    expect(page).to have_content(user2.posts_counter)
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path
    user5 = User.find_by(name: 'Pysduck')
    click_link user5.name
    expect(current_path).to eq(user_path(user5))
  end
end
