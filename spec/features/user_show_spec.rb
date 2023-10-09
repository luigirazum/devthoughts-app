# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'User Show Page' do
  before(:each) do
    @user1 = User.create(name: 'Pikachu', bio: 'Pokemon', photo: 'https://www.pngegg.com/en/png-wgjix',
                         posts_counter: 0)
    @post1 = Post.create(author: @user1, title: 'Game 1', text: 'I won')
    @post2 = Post.create(author: @user1, title: 'Game 2', text: 'I lost')
    @post3 = Post.create(author: @user1, title: 'Game 3', text: 'Draw')
    @post4 = Post.create(author: @user1, title: 'Game 4', text: 'difficult')
  end
  scenario 'I can see the username of the user' do
    visit user_path(@user1)

    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see the profile picture for each user' do
    visit user_path(@user1)

    expect(page).to have_css('img[src*="https://www.pngegg.com/en/png-wgjix"]')
  end

  scenario 'I can see the number of posts of the user' do
    visit user_path(@user1)

    expect(page).to have_content(@user1.posts_counter)
  end

  scenario 'I can see the bio of the user' do
    visit user_path(@user1)

    expect(page).to have_content(@user1.bio)
  end

  scenario 'I can see a button to view user\'s posts' do
    visit user_path(@user1)

    expect(page).to have_content('See all posts')
  end

  scenario 'I can see the last 3 posts of the user' do
    visit user_path(@user1)

    expect(page).to have_text(@post2.title, wait: 10)
    expect(page).to have_text(@post3.title, wait: 10)
    expect(page).to have_text(@post4.title, wait: 10)
  end

  #   scenario 'redirects to the post show page when you click on a users post' do
  #     click_link 'Game 1'
  #     expect(current_path).to eq(user_post_path(@user1, @post1))
  #   end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user1)

    click_link 'See all posts'

    expect(current_path).to eq(user_posts_path(@user1))
  end
end
# rubocop:enable Metrics/BlockLength