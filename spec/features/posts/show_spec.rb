require 'rails_helper'

RSpec.describe "Page: 'posts#show' | http://127.0.0.1:3000/users/:user_id/posts/:id", :integration, type: :system do
  let!(:user) { User.create(name: 'user name', bio: 'This is user Bio', photo: 'https://makeplaceholder.com?size=100&bg=f4bcae&text=photo&tcolor=ffffff&as=png') }
  let!(:post) { Post.create(author: user, title: 'Post title', text: 'This is the post body for post1') }
  let!(:comments) { [] }

  before(:each) do
    (1..8).each do |i|
      commenter = User.create(name: "commenter#{i}", bio: 'Commenter Bio', photo: "https://makeplaceholder.com?size=100&bg=f4bcae&text=commenter#{i}&tcolor=ffffff&as=png")
      comment = Comment.create(post:, user: commenter, text: "Comment for Post##{post.id}, from #{commenter.name}")
      comments << comment
    end
  end

  describe '* verifying page content', :content do
    describe "- post's info", :info do
      before { visit user_post_path(user, post) }

      it "> it shows the post's title" do
        expect(page).to have_css('h3', text: "Post ##{post.id}. #{post.title}")
      end

      it '> it shows who wrote the post' do
        expect(page).to have_css('h3 span', text: "by #{post.author.name}")
      end

      it '> it shows a [Like] button' do
        expect(page).to have_button('Like')
      end

      it '> it shows how many comments a post has' do
        expect(page).to have_css('p', text: 'Comments:')
        expect(page).to have_css('strong', text: post.comments_counter)
        expect(page).to have_css('p', text: "Comments: #{post.comments_counter}")
      end

      it '> it shows how many likes a post has' do
        expect(page).to have_css('p', text: 'Likes:')
        expect(page).to have_css('strong', text: post.likes_counter)
        expect(page).to have_css('p', text: /Likes: #{post.likes_counter}/)
      end

      it '> it shows the post body' do
        expect(page).to have_css('p', text: post.text)
      end
    end

    describe '- rendered comments', :comments do
      before { visit user_post_path(user, post) }

      it '> it shows all the comments that the post has' do
        selector = 'aside.all-comments'
        within(selector) { expect(page.all('.comment').count).to eq(post.comments.count) }
      end

      it '> it shows the username of each commentor' do
        selector = 'aside.all-comments'
        within(selector) do
          page.all('p.comment').each_with_index do |comment, i|
            expect(comment).to have_content("#{comments[i].user.name}: #{comments[i].text}")
            expect(comment).to have_css('span', text: /#{comments[i].user.name}:/)
            expect(comment).to have_content(/: #{comments[i].text}/)
          end
        end
      end

      it '> it shows the comment each commentor left' do
        selector = 'aside.all-comments'
        within(selector) do
          page.all('p.comment').each_with_index do |comment, i|
            expect(comment).to have_content(/: #{comments[i].text}/)
          end
        end
      end
    end
  end

  describe '* testing interactions', :interactions do
    before do
      visit user_post_path(user, post)
      @current_user = User.first
    end

    context '- clicking on [Like] button', :like do
      it '> increases the number of Likes that a post has' do
        click_on('Like')
        expect(page).to have_current_path(user_post_path(user, post))
        expect(page).to have_css('p', text: /Likes: #{post.likes_counter_was + 1}/)
      end
    end

    context '- clicking on [New Comment] button', :comment do
      it '> redirects to New Comment page' do
        click_on 'New comment'
        expect(page).to have_current_path(new_post_comment_path(post))
      end
    end
  end
end
