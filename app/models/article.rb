class Article < ApplicationRecord
    has_one_attached :eyecatch

    validates :title, presence: true
    validates :content, presence: true

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end
end
