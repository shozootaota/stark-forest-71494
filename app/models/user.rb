class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower


  has_one :profile, dependent: :destroy

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def liked?(article)
    likes.exists?(article_id: article.id)
  end

  def avatar_image
    profile&.avatar || 'default-avatar.png'
  end

  def follow!(user_id:)
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end

    following_relationships.create!(following_id: user.id)
  end

  def unfollow!(user)
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end

    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

end
