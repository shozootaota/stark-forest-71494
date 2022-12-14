class Article < ApplicationRecord
    has_one_attached :eyecatch

    validates :title, presence: true
    validates :title, length: { maximum: 36 }
    validates :content, presence: true
    validates :content, length: { maximum: 80 }

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end

    validates :eyecatch, presence: true, blob: { content_type: :image }
end
