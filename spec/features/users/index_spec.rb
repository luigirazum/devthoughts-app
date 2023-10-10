require 'rails_helper'

RSpec.describe "Page: 'users#index' | http://127.0.0.1:3000/", :integration, type: :system do
  let!(:users) { [] }

  before do
    names = %w[Pikachu Meowth Squirtle Charmander Pusduck]
    photos = %w[wgjix sigeb bsdir bntxq bnagx]
    5.times.each do |i|
      users << User.create(name: names[i], photo: "https://www.pngegg.com/en/png-#{photos[i]}")
    end
  end

  describe '* verifying page content', :content do
    describe '- users info', :info do
      before { visit users_path }

      it '> shows the username of all other users' do
        page.all('a.link-user').each_with_index do |user, i|
          expect(user).to have_css('.user .description h2', text: users[i].name)
        end
      end

      it '> shows the profile picture for each user' do
        page.all('a.link-user').each_with_index do |user, i|
          expect(user).to have_css("img[src*='#{users[i].photo}']")
        end
      end

      it '> shows the number of posts each user has written' do
        page.all('a.link-user').each_with_index do |user, i|
          expect(user).to have_css('p', text: 'Total Posts:')
          expect(user).to have_css('strong', text: users[i].posts_counter)
          expect(user).to have_css('p', text: /Total Posts: #{users[i].posts_counter}/)
        end
      end

      it '> every [user] showed is clickable (is a link)' do
        users.each do |user|
          expect(page).to have_css("a[href='/users/#{user.id}']")
        end
      end
    end
  end

  describe '* testing interactions', :interactions do
    describe '- when clicking on a [user] (link)', :links do
      before { visit users_path }

      it "> it redirects to that user's show page" do
        users.each do |user|
          find("a[href='#{user_path(user)}']").click
          expect(page).to have_current_path(user_path(user))
          visit users_path
        end
      end
    end
  end
end
