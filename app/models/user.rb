class User < ApplicationRecord
  before_create :default_bio_and_photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # validations
  validates :name, presence: { message: "can't be blank" }
  validates :name, length: { in: 5..50, message: 'must be 5 to 50 characters' }
  validates :posts_counter, numericality: { only_integer: true, message: 'must be an integer number' }
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, message: "can't be negative" }

  # associations
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'
  has_many :likes
  has_many :comments

  def most_recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end

  def to_s
    name
  end

  private

  def default_bio_and_photo
    self.name = name.downcase.capitalize
    self.photo = "https://makeplaceholder.com?size=100&bg=f4bcae&text=#{name.downcase}&tcolor=ffffff&as=png"
    self.bio = 'Please, share with the community a little about yourself.'
  end
end
