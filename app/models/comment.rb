class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :user # 追加
    validates :content, presence: true
    validates :content, length: { minimum: 2 }
end
