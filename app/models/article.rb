class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    has_many :comments, dependent: :destroy
    belongs_to :user

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end
end
