require 'rails_helper'

RSpec.describe "Page: 'posts#index' | http://127.0.0.1:3000/users/:id/posts", :integration, type: :system do
  let!(:user) { User.create(name: 'user name', bio: 'This is user Bio', photo: 'https://makeplaceholder.com?size=100&bg=f4bcae&text=photo&tcolor=ffffff&as=png') }
  let!(:post1) { Post.create(author: user, title: 'Post title', text: 'This is the post body for post1') }
  let!(:post2) { Post.create(author: user, title: 'Hello World', text: 'Hello body post for post2.') }

  before(:each) do
    commenter = User.create(name: 'commenter1', bio: 'Commenter Bio', photo: 'https://makeplaceholder.com?size=100&bg=f4bcae&text=photo&tcolor=ffffff&as=png')
    Comment.create(post: post1, user: commenter, text: 'Comment for post 1')
    Comment.create(post: post2, user: commenter, text: 'Comment for post 2')
  end

  describe '* verifying page content', :content do
    describe "- user's info", :info do
      before { visit user_posts_path(user) }

      it "> it shows the user's profile picture" do
        expect(page).to have_css("img[src*='#{user.photo}']")
      end

      it "> it shows the user's username" do
        expect(page).to have_css('h2', text: user.name)
      end

      it '> it shows a [New Post] button' do
        expect(page).to have_link('New Post')
      end

      it '> it shows the number of posts the user has written' do
        expect(page).to have_css('p', text: 'Total Posts:')
        expect(page).to have_css('strong', text: user.posts_counter)
        expect(page).to have_css('p', text: /Total Posts: #{user.posts_counter}/)
      end
    end

    describe '- rendered user posts', :posts do
      before { visit user_posts_path(user) }

      it '> it shows the title of each post' do
        [post1, post2].each do |post|
          expect(page).to have_css('p', text: "Post ##{post.id} | #{post.title}")
        end
      end

      it '--> each post title is clickable (is a link)' do
        [post1, post2].each do |post|
          expect(page).to have_link("Post ##{post.id} | #{post.title}")
        end
      end

      it '> each post has a [Like] button' do
        [post1, post2].each do
          expect(page).to have_button('Like')
        end
      end

      it '> it shows some of the body of each post' do
        [post1, post2].each do |post|
          expect(page).to have_css('p', text: post.text)
        end
      end

      it '> it shows how many comments a post has' do
        [post1, post2].each do |post|
          expect(page).to have_css('p', text: 'Comments:')
          expect(page).to have_css('strong', text: post.comments_counter)
          expect(page).to have_css('p', text: "Comments: #{post.comments_counter}")
        end
      end

      it '> it shows how many likes a post has' do
        [post1, post2].each do |post|
          expect(page).to have_css('p', text: 'Likes:')
          expect(page).to have_css('strong', text: post.likes_counter)
          expect(page).to have_css('p', text: /Likes: #{post.likes_counter}/)
        end
      end
    end

    describe '- rendered comments at each post' do
      before { visit user_posts_path(user) }

      it '> it shows the most recent comments on a post' do
        selector = '.all-posts'
        within(selector) { expect(page.all('aside.recent-comments').count).to eq(2) }
      end

      it '> it shows a [New comment] button' do
        [post1, post2].each do |post|
          expect(page).to have_css("a[href='#{new_post_comment_path(post)}']")
        end
      end
    end
  end

  describe '* testing interactions', :interactions do
    before do
      visit user_posts_path(user)
      @current_user = User.first
    end

    context '- clicking on [New Post] button', :post do
      it '> redirects to New Post page' do
        click_link 'New Post'
        expect(page).to have_current_path(new_post_path)
      end
    end

    context '- clicking [post title] link', :post do
      it "> it redirects me to that post's show page" do
        [post1, post2].each do |post|
          click_link "Post ##{post.id} | #{post.title}"
          expect(page).to have_current_path(user_post_path(user, post))
          visit user_posts_path(user)
        end
      end
    end

    context '- clicking on [New Comment] button', :comment do
      it '> redirects to New Comment page' do
        [post1, post2].each do |post|
          find("a[href='#{new_post_comment_path(post)}']").click
          expect(page).to have_current_path(new_post_comment_path(post))
          visit user_posts_path(user)
        end
      end
    end

    context '- clicking on [Like] button', :like do
      it '> increases the number of Likes that a post has' do
        posts = [post1, post2]
        page.all('form').each_with_index do |form, i|
          expect(form).to have_button('Like')
          form.click_on('Like')
          expect(page).to have_current_path(user_post_path(user, posts[i]))
          expect(page).to have_css('p', text: /Likes: #{posts[i].likes_counter_was + 1}/)
        end
      end
    end
  end
end
