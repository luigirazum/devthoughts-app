require 'rails_helper'

def extract_three_most_recent_posts(posts)
  post1, post2, post3, = posts

  [post1, post2, post3]
end

RSpec.describe "Page: 'users#show' | http://127.0.0.1:3000/users/:id", :integration, type: :system do
  let!(:author) { User.create(name: 'Pikachu', bio: 'Pokemon', photo: 'https://www.pngegg.com/en/png-wgjix') }
  let!(:posts) { [] }

  before(:each) do
    texts = %w[won lost draw difficult]
    (1..4).each do |num|
      time = Time.now - (2.hour * num.to_s.to_i)
      posts << Post.create(author:, title: "Game #{num}", text: "the game was #{texts[num - 1]}", created_at: time,
                           updated_at: time)
    end
    users = (1..5).map do |num|
      User.create(name: "user ##{num}", bio: "Bio for user #{num}", photo: "https://makeplaceholder.com?size=100&bg=f4bcae&text=photo#{num}&tcolor=ffffff&as=png")
    end
    posts.each do |post|
      commenters = users.sample(rand(users.size))
      likers = users.sample(rand(users.size))
      commenters.each do |commenter|
        post.comments.create(user: commenter, text: "Comment for post##{post.id}, by user '#{commenter.name}'")
      end
      likers.each do |liker|
        post.likes.create(user: liker)
      end
    end
  end

  describe '* verifying page content', :content do
    describe "- user's info", :info do
      before { visit user_path(author) }
      it "> it shows the user's profile picture" do
        expect(page).to have_css("img[src*='#{author.photo}']")
      end

      it "> it shows the user's username" do
        expect(page).to have_css('h2', text: author.name)
      end

      it '> it shows a [New Post] button' do
        expect(page).to have_link('New Post')
      end

      it '> it shows the number of posts the user has written' do
        expect(page).to have_css('p', text: 'Total Posts:')
        expect(page).to have_css('strong', text: author.posts_counter)
        expect(page).to have_css('p', text: /Total Posts: #{author.posts_counter}/)
      end

      it "> it shows the user's bio" do
        expect(page).to have_css('h3', text: 'Bio')
        expect(page).to have_css('p', text: author.bio)
      end
    end

    describe '- rendered user posts', :posts do
      before do
        @three_most_recent = extract_three_most_recent_posts(posts)
        visit user_path(author)
      end

      it '> it shows the three most recent posts' do
        selector = 'div.most-recent-list'
        within(selector) { expect(page.all('.post').count).to eq(author.most_recent_posts.count) }
      end

      it '> it shows the title of each post' do
        page.all('.post').each_with_index do |post, i|
          expect(post).to have_css('a p', text: "Post ##{@three_most_recent[i].id} | #{@three_most_recent[i].title}")
        end
      end

      it '--> each post title is clickable (is a link)' do
        page.all('.post').each_with_index do |post, i|
          link = "Post ##{@three_most_recent[i].id} | #{@three_most_recent[i].title}"
          expect(post).to have_link(link)
        end
      end

      it '> each post has a [Like] button' do
        page.all('.post').each do |post|
          expect(post).to have_button('Like')
        end
      end

      it '> it shows some of the body of each post' do
        page.all('.post').each_with_index do |post, i|
          expect(post).to have_css('p', text: @three_most_recent[i].text)
        end
      end

      it '> it shows how many comments a post has' do
        page.all('.post').each_with_index do |post, i|
          expect(post).to have_css('p', text: 'Comments:')
          expect(post).to have_css('strong', text: @three_most_recent[i].likes_counter)
          expect(post).to have_css('p', text: "Comments: #{@three_most_recent[i].comments_counter}")
        end
      end

      it '> it shows how many likes a post has' do
        page.all('.post').each_with_index do |post, i|
          expect(post).to have_css('p', text: 'Likes:')
          expect(post).to have_css('strong', text: @three_most_recent[i].likes_counter)
          expect(post).to have_css('p', text: /Likes: #{@three_most_recent[i].likes_counter}/)
        end
      end

      describe '- more elements', :elements do
        before { visit user_path(author) }

        it "> it shows a [See all posts] button to view all of a user's posts" do
          expect(page).to have_link('See all posts')
        end
      end
    end
  end

  describe '* testing interactions', :interactions do
    before do
      @three_most_recent = extract_three_most_recent_posts(posts)
      visit user_path(author)
    end

    context '- clicking on [New Post] button', :post do
      it '> redirects to New Post page' do
        click_link 'New Post'
        expect(page).to have_current_path(new_post_path)
      end
    end

    context '- clicking on [post title] link', :post do
      it "> it redirects me to that post's show page" do
        @three_most_recent.each do |post|
          click_link "Post ##{post.id} | #{post.title}"
          expect(page).to have_current_path(user_post_path(author, post))
          visit user_path(author)
        end
      end
    end

    context '- clicking on a [Like] button for certain post', :like do
      it '> increases the number of Likes that a post has' do
        page.all('.form').each_with_index do |button, i|
          button.click_on('Like')
          expect(page).to have_css('p', text: /Likes: #{@three_most_recent[i].reload.likes_counter_was + 1}/)
        end
      end
    end

    context '- clicking on [See all posts] button', :all_posts do
      it "> redirects me to the user's post's index page" do
        click_link 'See all posts'
        expect(page).to have_current_path(user_posts_path(author))
      end
    end
  end
end
